# Template: Python Project Analysis (Django/FastAPI/Flask)

Este template é aplicado automaticamente quando o sistema detecta um projeto Python (Django, FastAPI, Flask, etc.).

## 📋 Metadados Estruturados

```yaml
---
# Metadados estruturados para IA Processing
project_type: "python_project"
framework: "{{python_framework}}"
stack: {{stack_array}}
architecture_pattern: "{{architecture_pattern}}"
complexity_level: {{complexity}}
python_version: "{{python_version}}"
package_manager: "{{package_manager}}"
dependencies_count: {{dependencies_count}}
test_frameworks: {{test_frameworks}}
deployment_type: {{deployment_type}}
last_analysis: {{timestamp}}
confidence_score: {{confidence}}
estimated_dev_hours: {{estimated_hours}}
key_technologies: {{key_tech_array}}
integration_points: {{integration_count}}
python_metrics: {
  models_count: {{models_count}},
  views_count: {{views_count}},
  endpoints_count: {{endpoints_count}},
  migrations_count: {{migrations_count}},
  avg_response_time: {{response_time}}
}
---
```

## 🏗️ Estrutura do Documento Consolidado

### **# {{project_name}} - Análise Consolidada de Projeto Python**

## 📋 Project Overview

**Tipo**: Aplicação Python {{python_version}} com {{python_framework}} {{framework_version}}
**Stack Principal**: {{main_stack}}
**Arquitetura**: {{architecture_description}}
**Complexidade**: {{complexity_description}} ({{models_count}} models, {{views_count}} views)

### Quick Stats
- **Files**: {{total_files}} arquivos Python
- **Models**: {{models_count}} modelos de dados
- **Views/Endpoints**: {{views_count}} views/endpoints
- **Database**: {{database_type}} ({{migrations_count}} migrations)
- **Performance**: {{avg_response_time}}ms response time
- **Test Coverage**: {{test_coverage}}% ({{test_framework}})

## 🏗️ Architecture Analysis

### Application Architecture
```
{{application_structure}}
```

### Framework-specific Architecture
{{framework_specific_details}}

### Database Architecture
{{database_architecture}}

## 📚 Technology Stack

### Core Python Technologies
{{core_technologies}}

### Web Framework
{{web_framework_details}}

### Database & ORM
{{database_orm_details}}

### Development & Quality
{{dev_quality_tools}}

## 🗄️ Data Models & Database

### Models Structure
```
{{models_structure}}
```

### Database Schema
{{database_schema}}

### Relationships & Constraints
{{database_relationships}}

## 🔧 Application Structure

### Directory Structure
```
{{directory_structure}}
```

### Core Modules
{{core_modules}}

### Views & URL Patterns
{{views_urls_structure}}

## 🔗 API & Views

### Endpoints Structure
{{endpoints_structure}}

### Authentication & Authorization
{{auth_details}}

### Middleware & Permissions
{{middleware_permissions}}

## 🔗 Integration Points

{{integration_points_details}}

## 📊 Dependencies & Infrastructure

### Production Dependencies
{{production_dependencies}}

### Development Dependencies
{{development_dependencies}}

### Virtual Environment
{{virtual_env_details}}

### Configuration Management
{{config_management}}

## 🧪 Testing Strategy

### Testing Framework Setup
{{testing_setup}}

### Test Structure
```
{{test_structure}}
```

### Testing Patterns
{{testing_patterns}}

## 🚀 Development Workflow

### Management Commands
{{management_commands}}

### Development Environment
{{dev_environment}}

### Database Migrations
{{migrations_workflow}}

## 🔧 Configuration Files

### Primary Config Files
{{config_files_list}}

### Environment Configuration
{{environment_config}}

### Database Configuration
{{database_config}}

### Static Files & Media
{{static_media_config}}

## ⚠️ Challenges & Considerations

### Current Architecture Challenges
{{architecture_challenges}}

### Performance Considerations
{{performance_considerations}}

### Security Considerations
{{security_considerations}}

### Scalability Considerations
{{scalability_notes}}

---

## 🔄 Ready for build-tech-docs

Este documento consolidado está otimizado para acelerar o processo do `/docs/build-tech-docs`:

✅ **Análise Estrutural Completa** - Detectado automaticamente como Python {{python_framework}}  
✅ **Stack Identificado** - {{main_stack}}  
✅ **Arquitetura Mapeada** - {{architecture_pattern}} com {{python_framework}}  
✅ **Models Catalogados** - {{models_count}} models com {{database_type}}  
✅ **Views/Endpoints** - {{views_count}} views com {{auth_method}}  
✅ **Database Schema** - {{migrations_count}} migrations aplicadas  
✅ **Challenges Identificados** - Performance e oportunidades de otimização  

**Próximo passo**: Use este documento como input para `/docs/build-tech-docs` para gerar a documentação técnica completa em 9 arquivos.
