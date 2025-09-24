# 🔍 Project Detection Strategy - C4 Architecture Specialist

## 📋 **Auto-Detection Algorithm**

### **Detection Sequence:**
1. **Root Analysis** → package.json, workspace files, config files
2. **Directory Structure** → Standard patterns and conventions
3. **Dependency Analysis** → Key dependencies that indicate project type
4. **Build System Detection** → Build tools and configurations
5. **Framework Detection** → Specific framework artifacts

---

## 🕵️ **Detection Rules**

### **🏢 Monorepo Detection**
```typescript
interface MonorepoDetection {
  // NX Monorepo
  nxWorkspace: 'nx.json exists + workspace.json/angular.json'
  nxIndicators: ['@nx/', '@nrwl/', 'nx.json', 'project.json files']
  
  // Lerna Monorepo  
  lernaWorkspace: 'lerna.json exists + packages/ directory'
  lernaIndicators: ['lerna.json', 'packages/*', 'lerna command in package.json']
  
  // npm/yarn Workspaces
  npmWorkspace: 'package.json workspaces field'
  yarnWorkspace: 'yarn workspace commands or workspaces in package.json'
  
  // pnpm Workspaces
  pnpmWorkspace: 'pnpm-workspace.yaml exists'
}
```

### **🖥️ Single Page Application (SPA)**
```typescript
interface SPADetection {
  // React SPA
  reactSpa: {
    indicators: ['react', 'react-dom in deps', 'src/App.tsx|jsx', 'public/index.html']
    buildTool: 'create-react-app | vite | webpack config'
    patterns: ['src/components/', 'src/pages/', 'src/hooks/']
  }
  
  // Vue SPA  
  vueSpa: {
    indicators: ['vue in deps', 'src/App.vue', 'src/main.ts']
    buildTool: 'vue-cli | vite config'
    patterns: ['src/components/', 'src/views/', 'src/router/']
  }
  
  // Angular SPA
  angularSpa: {
    indicators: ['@angular/core', 'angular.json', 'src/app/app.module.ts']
    buildTool: 'angular-cli'
    patterns: ['src/app/', 'src/environments/']
  }
}
```

### **🔌 API Service Detection**
```typescript
interface APIDetection {
  // Express.js API
  expressApi: {
    indicators: ['express in deps', 'app.js|ts', 'server.js|ts']
    patterns: ['routes/', 'controllers/', 'middleware/', 'models/']
  }
  
  // Fastify API
  fastifyApi: {
    indicators: ['fastify in deps', 'server.ts', 'app.ts']
    patterns: ['routes/', 'plugins/', 'schemas/']
  }
  
  // NestJS API
  nestjsApi: {
    indicators: ['@nestjs/core', 'nest-cli.json', 'src/main.ts']
    patterns: ['src/modules/', 'src/controllers/', 'src/services/']
  }
}
```

### **🌐 Full-stack Application**
```typescript
interface FullstackDetection {
  // Next.js
  nextjsApp: {
    indicators: ['next in deps', 'next.config.js', 'pages/ or app/ directory']
    patterns: ['pages/api/', 'app/api/', 'pages/_app.tsx', 'components/']
  }
  
  // Nuxt.js
  nuxtjsApp: {
    indicators: ['nuxt in deps', 'nuxt.config.js', 'pages/ directory']
    patterns: ['pages/', 'components/', 'server/', 'plugins/']
  }
}
```

### **☁️ Serverless Detection**
```typescript
interface ServerlessDetection {
  awsLambda: {
    indicators: ['serverless.yml', 'aws-lambda in deps', 'handler.js|ts']
    patterns: ['functions/', 'lambda/', 'src/handlers/']
  }
  
  vercelFunctions: {
    indicators: ['vercel.json', 'api/ directory', '@vercel/node']
    patterns: ['api/', 'functions/']
  }
  
  netlifyFunctions: {
    indicators: ['netlify.toml', 'netlify/ directory']
    patterns: ['netlify/functions/', '.netlify/functions/']
  }
}
```

---

## 🎯 **Detection Implementation**

```typescript
class ProjectTypeDetector {
  async detectProjectType(projectPath: string): Promise<ProjectDetectionResult> {
    const detectionSteps = [
      this.detectMonorepo(projectPath),
      this.detectSPA(projectPath),
      this.detectAPI(projectPath),
      this.detectFullstack(projectPath),
      this.detectServerless(projectPath),
    ]
    
    const results = await Promise.all(detectionSteps)
    return this.consolidateResults(results)
  }
  
  private async detectMonorepo(path: string): Promise<DetectionResult> {
    const indicators = {
      nx: await this.checkFiles(path, ['nx.json', 'workspace.json', 'angular.json']),
      lerna: await this.checkFiles(path, ['lerna.json', 'packages']),
      npmWorkspaces: await this.checkWorkspaceField(path),
      pnpmWorkspaces: await this.checkFiles(path, ['pnpm-workspace.yaml'])
    }
    
    return this.calculateConfidence(indicators, 'monorepo')
  }
  
  private async detectSPA(path: string): Promise<DetectionResult> {
    const packageJson = await this.readPackageJson(path)
    const indicators = {
      react: this.hasDependency(packageJson, ['react', 'react-dom']),
      vue: this.hasDependency(packageJson, ['vue']),
      angular: this.hasDependency(packageJson, ['@angular/core'])
    }
    
    return this.calculateConfidence(indicators, 'spa')
  }
  
  // ... similar methods for other project types
}
```

---

## 📊 **Confidence Scoring**

### **Scoring Algorithm:**
```typescript
interface ConfidenceFactors {
  primaryIndicators: number     // 40% weight (key files, dependencies)
  structuralPatterns: number    // 30% weight (directory structure)
  buildConfiguration: number    // 20% weight (build tools, configs)
  namingConventions: number     // 10% weight (file naming patterns)
}

const calculateConfidence = (factors: ConfidenceFactors): number => {
  return (
    factors.primaryIndicators * 0.4 +
    factors.structuralPatterns * 0.3 +
    factors.buildConfiguration * 0.2 +
    factors.namingConventions * 0.1
  ) * 100 // Convert to percentage
}
```

### **Confidence Levels:**
- **90-100%**: Definitive match (proceed with high confidence)
- **70-89%**: Strong match (proceed with validation)
- **50-69%**: Moderate match (request user confirmation)
- **< 50%**: Weak match (fallback to generic template)

---

## 🚨 **Edge Cases & Fallbacks**

### **Complex Projects:**
```typescript
interface ComplexProjectHandling {
  multiplePatterns: {
    // When project matches multiple patterns
    strategy: 'confidence-based-selection'
    fallback: 'user-prompt-for-primary-type'
  }
  
  hybridArchitecture: {
    // Full-stack + API + SPA in one project
    strategy: 'hierarchical-analysis'
    example: 'Next.js with separate API services'
  }
  
  customArchitecture: {
    // Doesn't match any standard pattern
    strategy: 'generic-template-with-customization'
    enhancement: 'learn-from-user-input'
  }
}
```

### **Fallback Strategy:**
1. **Generic TypeScript Project**: Basic template focused on imports/exports
2. **User Guidance**: Prompt for manual project type selection
3. **Learning Mode**: Remember user corrections for similar projects
4. **Hybrid Mode**: Apply multiple templates with confidence weighting

---

## 🎨 **Template Mapping**

```typescript
const projectTypeToTemplate: Record<ProjectType, TemplateConfiguration> = {
  'spa-react': {
    contextTemplate: 'single-application',
    containerTemplate: 'client-server-separation',
    componentTemplate: 'react-component-hierarchy'
  },
  
  'node-api': {
    contextTemplate: 'api-service',
    containerTemplate: 'layered-api-architecture',
    componentTemplate: 'route-controller-service'
  },
  
  'nx-monorepo': {
    contextTemplate: 'workspace-overview',
    containerTemplate: 'apps-and-libs',
    componentTemplate: 'lib-internal-structure'
  }
  
  // ... other mappings
}
```

---

**Estratégia de Detecção**: 📍 **Project-Agnostic com Alta Precisão**  
**Implementação**: Multi-step detection com confidence scoring  
**Fallback**: Generic template + user guidance quando necessário

