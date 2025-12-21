/**
 * onion init - Inicializar Sistema Onion
 */
import { detectOnionProject, detectOnionV3Structure } from '../core/detector.js';
import { createConfig, createDefaultConfig } from '../core/config.js';
import {
  generateCoreStructure,
  generateContextStructure,
  generateIDEStructure,
  generateIDELoader,
  generateDocsStructure,
  generateStarterCommands
} from '../generator/structure.js';
import WizardSteps from '../wizard/steps.js';
import logger from '../utils/logger.js';
import inquirer from 'inquirer';

export async function init(options = {}) {
  try {
    const projectRoot = process.cwd();
    
    // 1. Verificar se já existe estrutura Onion
    const existing = await detectOnionProject(projectRoot);
    
    if (existing) {
      logger.warn(`⚠️  Onion ${existing.version} structure already exists!`);
      logger.info('Use "onion validate" to check structure');
      if (existing.version === 'v3') {
        logger.info('Use "onion migrate" to upgrade to v4');
      }
      process.exit(1);
    }
    
    // 2. Verificar se tem estrutura legacy (v3)
    const v3Structure = await detectOnionV3Structure(projectRoot);
    
    if (v3Structure) {
      logger.warn('⚠️  Detected Onion v3 (.cursor/) structure');
      logger.break();
      
      const { shouldMigrate } = await inquirer.prompt([
        {
          type: 'confirm',
          name: 'shouldMigrate',
          message: 'Run migration to v4 instead?',
          default: true
        }
      ]);
      
      if (shouldMigrate) {
        const { migrate } = await import('./migrate.js');
        return await migrate(options);
      }
    }
    
    // 3. Executar wizard
    logger.title('🧅 Welcome to Onion System v4.0');
    logger.break();
    
    const wizard = new WizardSteps(projectRoot);
    const answers = await wizard.run();
    
    // 4. Gerar estrutura
    logger.break();
    logger.title('🎉 Creating Onion System structure...');
    logger.break();
    
    // 4.1. Core
    logger.startSpinner('Creating core structure...');
    await generateCoreStructure(projectRoot);
    logger.stopSpinner(true, 'Created .onion/core/');
    
    // 4.2. Contexts
    for (const contextName of answers.contexts) {
      logger.startSpinner(`Creating context: ${contextName}...`);
      
      await generateContextStructure(projectRoot, contextName, {
        includeREADME: true,
        includeConfig: true
      });
      
      // Gerar comandos starter
      const contextType = inferContextType(contextName);
      await generateStarterCommands(projectRoot, contextName, contextType);
      
      logger.stopSpinner(true, `Created .onion/contexts/${contextName}/`);
    }
    
    // 4.3. IDEs
    logger.startSpinner('Creating IDE integrations...');
    await generateIDEStructure(projectRoot, answers.ides);
    
    for (const ide of answers.ides) {
      await generateIDELoader(projectRoot, ide, {
        contexts: answers.contexts
      });
    }
    logger.stopSpinner(true, 'Created .onion/ide/');
    
    // 4.4. Docs
    logger.startSpinner('Creating documentation structure...');
    await generateDocsStructure(projectRoot, answers.contexts);
    logger.stopSpinner(true, 'Created docs/ structure');
    
    // 5. Gerar configuração
    logger.startSpinner('Generating .onion-config.yml...');
    
    const configData = createDefaultConfig({
      version: '4.0.0',
      contexts: answers.contexts,
      ides: answers.ides,
      integrations: {
        task_manager: answers.taskManager !== 'none' ? {
          provider: answers.taskManager,
          config_key: `${answers.taskManager.toUpperCase()}_API_TOKEN`
        } : null,
        transcription: answers.transcription !== 'none' ? {
          provider: answers.transcription
        } : null
      },
      project_type: answers.projectType
    });
    
    await createConfig(projectRoot, configData);
    logger.stopSpinner(true, 'Created .onion-config.yml');
    
    // 6. Adicionar ao Git (se aplicável)
    const { execa } = await import('execa');
    try {
      await execa('git', ['rev-parse', '--git-dir'], { cwd: projectRoot });
      logger.startSpinner('Adding to git...');
      await execa('git', ['add', '.onion/', '.onion-config.yml'], { cwd: projectRoot });
      logger.stopSpinner(true, 'Added to git');
    } catch {
      // Não é repositório git, ignorar
    }
    
    // 7. Success message
    logger.break();
    logger.title('✅ Onion System v4.0 initialized successfully!');
    logger.break();
    
    logger.success('Next steps:');
    logger.info(`  1. Explore contexts: /${answers.contexts[0]}/help`);
    logger.info('  2. Read documentation: docs/onion/');
    logger.info('  3. Start developing: /technical/work');
    logger.break();
    
  } catch (error) {
    logger.break();
    logger.error('❌ Initialization failed:');
    logger.error(error.message);
    if (options.debug) {
      console.error(error);
    }
    process.exit(1);
  }
}

/**
 * Infere tipo de contexto baseado no nome
 * @private
 */
function inferContextType(contextName) {
  const businessKeywords = ['business', 'product', 'strategy'];
  const technicalKeywords = ['technical', 'engineering', 'development', 'dev'];
  
  const lower = contextName.toLowerCase();
  
  if (businessKeywords.some(kw => lower.includes(kw))) {
    return 'business';
  }
  
  if (technicalKeywords.some(kw => lower.includes(kw))) {
    return 'technical';
  }
  
  return 'custom';
}

export default init;

