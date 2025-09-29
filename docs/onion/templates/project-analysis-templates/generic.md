# Template: Generic Project Analysis

Este template é aplicado automaticamente quando o sistema não consegue identificar com confiança o tipo específico do projeto (fallback universal).

## 📋 Metadados Estruturados

```yaml
---
# Metadados estruturados para IA Processing
project_type: "generic"
detected_languages: {{detected_languages}}
stack: {{stack_array}}
architecture_pattern: "{{architecture_pattern}}"
complexity_level: {{complexity}}
build_tools: {{build_tools_array}}
package_managers: {{package_managers_array}}
dependencies_count: {{dependencies_count}}
test_frameworks: {{test_frameworks}}
deployment_indicators: {{deployment_indicators}}
last_analysis: {{timestamp}}
confidence_score: {{confidence}}
estimated_dev_hours: {{estimated_hours}}
key_technologies: {{key_tech_array}}
integration_points: {{integration_count}}
project_metrics: {
  total_files: {{total_files}},
  code_files: {{code_files}},
  config_files: {{config_files}},
  documentation_files: {{doc_files}},
  primary_language: "{{primary_language}}"
}
---
```

## 🏗️ Estrutura do Documento Consolidado

### **# {{project_name}} - Análise Consolidada de Projeto**

## 📋 Project Overview

**Tipo**: Projeto de Software {{project_category}}
**Linguagem Principal**: {{primary_language}} ({{primary_lang_percentage}}%)
**Arquitetura**: {{architecture_description}}
**Complexidade**: {{complexity_description}} ({{total_files}} arquivos, {{code_files}} código)

### Quick Stats
- **Total Files**: {{total_files}} arquivos
- **Code Files**: {{code_files}} arquivos de código
- **Languages**: {{languages_list}}
- **Build Tools**: {{build_tools_detected}}
- **Dependencies**: {{dependencies_count}} dependências
- **Documentation**: {{documentation_coverage}}

## 🏗️ Architecture Analysis

### Project Structure
```
{{project_structure}}
```

### Identified Patterns
{{identified_patterns}}

### Technology Detection
{{technology_detection}}

## 📚 Technology Stack

### Detected Technologies
{{detected_technologies}}

### Configuration Files
{{configuration_files}}

### Build & Development Tools
{{build_dev_tools}}

## 🗂️ Project Structure

### Directory Organization
```
{{directory_organization}}
```

### Key Files & Directories
{{key_files_directories}}

### Code Organization
{{code_organization}}

## 🔧 Development Setup

### Environment Requirements
{{environment_requirements}}

### Build Process
{{build_process}}

### Development Workflow
{{development_workflow}}

## 🔗 Integration Points

{{integration_points_details}}

## 📊 Dependencies & Configuration

### Dependency Management
{{dependency_management}}

### Configuration Files
{{config_files_analysis}}

### Environment Setup
{{environment_setup}}

## 🧪 Testing & Quality

### Testing Setup
{{testing_setup}}

### Quality Assurance
{{quality_assurance}}

### Documentation
{{documentation_analysis}}

## 🚀 Development Information

### Getting Started
{{getting_started_info}}

### Available Commands
{{available_commands}}

### Development Environment
{{dev_environment_info}}

## 🔧 Configuration Analysis

### Primary Config Files
{{config_files_list}}

### Environment Variables
{{environment_variables}}

### External Dependencies
{{external_dependencies}}

## ⚠️ Analysis Notes & Recommendations

### Detected Patterns
{{detected_patterns_details}}

### Potential Improvements
{{potential_improvements}}

### Architecture Recommendations
{{architecture_recommendations}}

### Technology Recommendations
{{technology_recommendations}}

---

## 🔄 Ready for build-tech-docs

Este documento consolidado está otimizado para acelerar o processo do `/docs/build-tech-docs`:

✅ **Análise Estrutural Completa** - Projeto analisado como {{project_category}}  
✅ **Stack Identificado** - {{primary_language}} + {{secondary_technologies}}  
✅ **Arquitetura Detectada** - {{architecture_pattern}}  
✅ **Dependências Catalogadas** - {{dependencies_count}} dependências identificadas  
✅ **Build Process** - {{build_tools_detected}} detectado  
✅ **Estrutura Mapeada** - {{total_files}} arquivos organizados  

**Nota**: Como este projeto não foi categorizado automaticamente, o `/docs/build-tech-docs` pode precisar de contexto adicional durante as perguntas interativas.

**Próximo passo**: Use este documento como input para `/docs/build-tech-docs` para gerar a documentação técnica completa em 9 arquivos.
