# Formato Consolidado de Output - Template Engine

Este documento define o formato padrão e o sistema de aplicação de templates para o Sistema de Engenharia Reversa Universal.

## 🎯 **Objetivo do Template Engine**

O Template Engine Adaptativo é responsável por:
1. **Selecionar** template apropriado baseado na detecção de projeto
2. **Aplicar** dados específicos do projeto no template
3. **Gerar** documento consolidado em formato híbrido
4. **Otimizar** output para processamento por IA e legibilidade humana

## 🏗️ **Sistema de Aplicação de Templates**

### **Template Selection Logic**
```python
def select_template(detection_result: ProjectDetection) -> TemplateChoice:
    """
    Seleciona template baseado na detecção de projeto
    """
    template_mapping = {
        # Frontend Frameworks
        "react_spa": "react-spa.md",
        "vue_spa": "react-spa.md",  # React template serves Vue too
        "angular_spa": "react-spa.md",  # React template serves Angular too
        
        # Backend APIs
        "nodejs_api": "nodejs-api.md",
        "express_api": "nodejs-api.md", 
        "fastify_api": "nodejs-api.md",
        "nestjs_api": "nodejs-api.md",
        
        # Python Projects
        "python_django": "python-project.md",
        "python_fastapi": "python-project.md",
        "python_flask": "python-project.md",
        "python_generic": "python-project.md",
        
        # Full-stack
        "nextjs_fullstack": "fullstack.md",
        "nuxtjs_fullstack": "fullstack.md",
        "sveltekit_fullstack": "fullstack.md",
        
        # Fallback
        "generic": "generic.md",
        "unknown": "generic.md"
    }
    
    template_path = template_mapping.get(
        detection_result.project_type, 
        "generic.md"
    )
    
    # Use fallback if confidence is low
    if detection_result.confidence < 70:
        template_path = "generic.md"
        
    return TemplateChoice(
        path=f"templates/project-analysis-templates/{template_path}",
        type=detection_result.project_type,
        confidence=detection_result.confidence,
        fallback_used=detection_result.confidence < 70
    )
```

### **Template Variable Substitution**
```python
class TemplateProcessor:
    def __init__(self, template_path: str, analysis_data: ProjectAnalysis):
        self.template_content = self.load_template(template_path)
        self.analysis_data = analysis_data
        self.variables = self.extract_template_variables()
        
    def extract_template_variables(self) -> List[str]:
        """
        Extrai todas as variáveis {{variable}} do template
        """
        import re
        pattern = r'\{\{([^}]+)\}\}'
        return re.findall(pattern, self.template_content)
    
    def generate_variable_values(self) -> Dict[str, Any]:
        """
        Gera valores para todas as variáveis do template
        """
        values = {}
        
        # Basic project info
        values.update(self._generate_basic_info())
        
        # Stack-specific values
        values.update(self._generate_stack_values())
        
        # Performance metrics
        values.update(self._generate_performance_values())
        
        # Architecture details
        values.update(self._generate_architecture_values())
        
        return values
    
    def apply_template(self) -> str:
        """
        Aplica dados ao template gerando documento final
        """
        variable_values = self.generate_variable_values()
        
        processed_content = self.template_content
        
        for variable, value in variable_values.items():
            placeholder = f"{{{{{variable}}}}}"
            processed_content = processed_content.replace(placeholder, str(value))
            
        return processed_content
```

## 📊 **Formato Híbrido Estruturado**

### **Estrutura Padrão do Output**
```markdown
---
# METADADOS YAML FRONTMATTER (para IA)
project_type: "tipo_detectado"
stack: ["Tech1", "Tech2", "Tech3"]
architecture_pattern: "pattern_name"
complexity_level: "low|medium|high"
confidence_score: 0-100
last_analysis: "ISO-8601-timestamp"
key_metrics: {
  estimated_dev_hours: 123,
  dependencies_count: 45,
  files_analyzed: 67
}
---

# CONTEÚDO LEGÍVEL PARA HUMANOS
# [Project Name] - Análise Consolidada

## 📋 Project Overview
[Resumo executivo do projeto...]

## 🏗️ Architecture Analysis
[Detalhes arquiteturais...]

[... resto do conteúdo estruturado ...]

---
## 🔄 Ready for build-tech-docs
[Resumo otimizado para próximo passo...]
```

### **Metadados Obrigatórios (YAML Frontmatter)**
```yaml
# Identificação
project_type: string              # Tipo detectado (react_spa, nodejs_api, etc.)
stack: array[string]              # Technologies principais
architecture_pattern: string     # Padrão arquitetural identificado
complexity_level: string         # low, medium, high
confidence_score: number         # 0-100 score da detecção

# Análise
last_analysis: string            # ISO 8601 timestamp
estimated_dev_hours: number     # Estimativa de horas de desenvolvimento
dependencies_count: number      # Número de dependências
integration_points: number      # Pontos de integração externa

# Performance (se disponível)
performance_indicators: object  # Métricas específicas do tipo de projeto
```

### **Seções Obrigatórias (Conteúdo Humano)**
```markdown
1. # [Project] - Análise Consolidada      # Título dinâmico
2. ## 📋 Project Overview                  # Overview executivo
3. ## 🏗️ Architecture Analysis           # Análise arquitetural
4. ## 📚 Technology Stack                # Stack tecnológico
5. ## 🔗 Integration Points              # Integrações externas
6. ## 📊 Dependencies & Infrastructure    # Dependências e infra
7. ## ⚠️ Challenges & Considerations     # Desafios identificados
8. ## 🔄 Ready for build-tech-docs       # Resumo para próxima etapa
```

## 🎨 **Templates Específicos - Variáveis Customizadas**

### **React SPA Variables**
```python
react_spa_variables = {
    # Basic info
    "project_name": analysis.project_name,
    "react_version": analysis.get_package_version("react"),
    "main_stack": analysis.get_main_stack_description(),
    "complexity": analysis.complexity_level,
    "component_count": analysis.count_react_components(),
    "hook_count": analysis.count_custom_hooks(),
    
    # Architecture  
    "component_structure": analysis.generate_component_tree(),
    "state_management_approach": analysis.detect_state_management(),
    "routing_details": analysis.analyze_routing_setup(),
    
    # Performance
    "bundle_size": analysis.estimate_bundle_size(),
    "lighthouse_score": analysis.get_lighthouse_score() or "N/A",
    "load_time": analysis.estimate_load_time(),
    
    # Dependencies
    "prod_deps_count": len(analysis.production_dependencies),
    "dev_deps_count": len(analysis.development_dependencies),
    
    # Arrays for YAML
    "stack_array": analysis.stack_as_array(),
    "key_tech_array": analysis.key_technologies_array()
}
```

### **Node.js API Variables**
```python
nodejs_api_variables = {
    # Basic info
    "project_name": analysis.project_name,
    "node_version": analysis.get_node_version(),
    "framework": analysis.detect_nodejs_framework(),
    "architecture_description": analysis.get_architecture_description(),
    
    # API specific
    "endpoints_count": analysis.count_api_endpoints(),
    "middleware_count": analysis.count_middleware(),
    "database_type": analysis.detect_database_type(),
    "db_connections": analysis.count_database_connections(),
    
    # Performance
    "avg_response_time": analysis.estimate_response_time() or "N/A",
    "api_structure": analysis.generate_api_structure(),
    
    # Architecture
    "middleware_details": analysis.get_middleware_details(),
    "database_details": analysis.get_database_integration_details(),
    
    # Arrays for YAML
    "stack_array": analysis.stack_as_array(),
    "api_metrics": analysis.get_api_metrics_dict()
}
```

## 🔧 **Sistema de Validação**

### **Template Validation**
```python
class TemplateValidator:
    def validate_template_syntax(self, template_content: str) -> ValidationResult:
        """
        Valida sintaxe do template
        """
        result = ValidationResult()
        
        # Check YAML frontmatter
        result.yaml_valid = self._validate_yaml_frontmatter(template_content)
        
        # Check required sections
        result.sections_complete = self._validate_required_sections(template_content)
        
        # Check variable placeholders
        result.variables_valid = self._validate_template_variables(template_content)
        
        return result
    
    def validate_generated_output(self, output_content: str) -> ValidationResult:
        """
        Valida documento gerado
        """
        result = ValidationResult()
        
        # Check hybrid format
        result.hybrid_format = self._has_yaml_frontmatter_and_content(output_content)
        
        # Check completeness  
        result.content_complete = self._check_content_completeness(output_content)
        
        # Check build-tech-docs compatibility
        result.compatible = self._check_build_tech_docs_compatibility(output_content)
        
        return result
```

### **Quality Assurance Checks**
```python
def quality_assurance_pipeline(generated_doc: str) -> QualityReport:
    """
    Pipeline completo de QA para documento gerado
    """
    report = QualityReport()
    
    # Format validation
    report.format_valid = validate_hybrid_format(generated_doc)
    
    # Content quality
    report.content_score = calculate_content_quality_score(generated_doc)
    
    # AI optimization
    report.ai_optimized = check_ai_optimization_features(generated_doc)
    
    # Human readability  
    report.human_readable = assess_human_readability(generated_doc)
    
    # Integration compatibility
    report.integration_ready = test_build_tech_docs_compatibility(generated_doc)
    
    return report
```

## 🚀 **Integração com Comando Orquestrador**

### **Usage by /docs/reverse-consolidate**
```python
# No comando orquestrador (Phase 2)
def generate_consolidated_document(analysis: ProjectAnalysis) -> ConsolidatedDocument:
    """
    Integração com template engine (Phase 3)
    """
    # Select appropriate template
    template_choice = select_template(analysis.detection)
    
    # Load and process template
    processor = TemplateProcessor(template_choice.path, analysis)
    
    # Generate final document
    consolidated_content = processor.apply_template()
    
    # Validate output
    validation = TemplateValidator().validate_generated_output(consolidated_content)
    
    if not validation.is_valid:
        # Fallback to generic template
        generic_processor = TemplateProcessor("templates/generic.md", analysis)
        consolidated_content = generic_processor.apply_template()
    
    return ConsolidatedDocument(
        content=consolidated_content,
        template_used=template_choice.path,
        validation_passed=validation.is_valid,
        metadata=analysis.detection
    )
```

## 📈 **Performance & Optimization**

### **Template Caching**
```python
class TemplateCache:
    def __init__(self):
        self._template_cache = {}
        self._processed_cache = {}
    
    def get_template(self, template_path: str) -> str:
        """
        Cache de templates carregados
        """
        if template_path not in self._template_cache:
            self._template_cache[template_path] = self._load_template_file(template_path)
        return self._template_cache[template_path]
    
    def cache_processed_result(self, analysis_hash: str, result: str):
        """
        Cache de resultados processados
        """
        self._processed_cache[analysis_hash] = result
```

### **Batch Processing**
```python
def process_multiple_projects(project_paths: List[str]) -> List[ConsolidatedDocument]:
    """
    Processamento em lote otimizado
    """
    results = []
    template_cache = TemplateCache()
    
    for project_path in project_paths:
        analysis = analyze_project(project_path)
        template_choice = select_template(analysis.detection)
        
        # Use cached template
        template_content = template_cache.get_template(template_choice.path)
        
        # Process with optimizations
        processor = TemplateProcessor(template_content, analysis)
        result = processor.apply_template_optimized()
        
        results.append(result)
    
    return results
```

---

## 🎯 **Success Metrics**

### **Template Engine Success Criteria**
- **Template Coverage**: 95%+ dos projetos devem usar template específico (não generic)
- **Processing Speed**: <30 segundos para aplicar template em projeto médio
- **Content Quality**: 90%+ de informações relevantes preservadas
- **Format Consistency**: 100% dos outputs seguem formato híbrido padrão
- **Integration Success**: 100% compatibilidade com `/docs/build-tech-docs`

### **Quality Benchmarks**
- **YAML Validity**: 100% dos metadados devem ser YAML válido
- **Human Readability**: Score >80 em métricas de legibilidade
- **AI Optimization**: Metadados devem acelerar processamento IA em >50%
- **Template Accuracy**: <5% de placeholders não substituídos

---

## 🚀 **Status de Implementação**

**Template Engine**: ✅ **DESIGN COMPLETO - READY FOR INTEGRATION**

**Próximos passos**:
1. Integrar com comando orquestrador (Phase 2)
2. Implementar sistema de validação
3. Testar com projetos reais (Phase 4)
4. Otimizar performance para projetos grandes
