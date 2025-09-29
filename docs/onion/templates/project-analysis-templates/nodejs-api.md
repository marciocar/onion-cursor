# Template: Node.js API Analysis

Este template é aplicado automaticamente quando o sistema detecta um projeto Node.js API (Express, Fastify, NestJS, etc.).

## 📋 Metadados Estruturados

```yaml
---
# Metadados estruturados para IA Processing
project_type: "nodejs_api"
stack: {{stack_array}}
architecture_pattern: "{{architecture_pattern}}"
complexity_level: {{complexity}}
build_tool: {{build_tool}}
package_manager: {{package_manager}}
dependencies_count: {{dependencies_count}}
test_frameworks: {{test_frameworks}}
deployment_type: {{deployment_type}}
last_analysis: {{timestamp}}
confidence_score: {{confidence}}
estimated_dev_hours: {{estimated_hours}}
key_technologies: {{key_tech_array}}
integration_points: {{integration_count}}
api_metrics: {
  endpoints_count: {{endpoints_count}},
  middleware_count: {{middleware_count}},
  database_connections: {{db_connections}},
  avg_response_time: {{response_time}}
}
---
```

## 🏗️ Estrutura do Documento Consolidado

### **# {{project_name}} - Análise Consolidada de API Node.js**

## 📋 Project Overview

**Tipo**: API Backend Node.js {{node_version}} com {{framework}}
**Stack Principal**: {{main_stack}}
**Arquitetura**: {{architecture_description}}
**Complexidade**: {{complexity_description}} ({{endpoints_count}} endpoints, {{middleware_count}} middlewares)

### Quick Stats
- **Files**: {{total_files}} arquivos de código
- **API Endpoints**: {{endpoints_count}} endpoints
- **Middleware**: {{middleware_count}} middlewares
- **Database**: {{database_type}} ({{db_connections}} connections)
- **Performance**: {{avg_response_time}}ms response time
- **Test Coverage**: {{test_coverage}}% ({{test_framework}})

## 🏗️ Architecture Analysis

### API Architecture
```
{{api_structure}}
```

### Middleware Stack
{{middleware_details}}

### Database Integration
{{database_details}}

## 📚 Technology Stack

### Core Technologies
{{core_technologies}}

### Database & Persistence
{{database_stack}}

### Authentication & Security
{{auth_security_details}}

### Development & Quality
{{dev_quality_tools}}

## 🔗 API Endpoints

### Endpoint Structure
{{endpoints_structure}}

### Authentication Flow
{{auth_flow_details}}

### Request/Response Patterns
{{request_response_patterns}}

## 🔧 Application Structure

### Directory Structure
```
{{directory_structure}}
```

### Core Modules
{{core_modules_list}}

### Services & Controllers
{{services_controllers}}

## 🗄️ Database Design

### Data Models
{{data_models}}

### Relationships
{{database_relationships}}

### Migrations & Schema
{{migrations_schema}}

## 🔗 Integration Points

{{integration_points_details}}

## 📊 Dependencies & Infrastructure

### Production Dependencies ({{prod_deps_count}} packages)
{{production_dependencies}}

### Development Dependencies ({{dev_deps_count}} packages)
{{development_dependencies}}

### Environment Configuration
{{environment_config}}

### Performance Characteristics
{{performance_details}}

## 🧪 Testing Strategy

### Testing Framework Setup
{{testing_setup}}

### Test Structure
```
{{test_structure}}
```

### API Testing Patterns
{{api_testing_patterns}}

## 🚀 Development Workflow

### Available Scripts
{{npm_scripts}}

### Development Environment
{{dev_environment}}

### API Documentation
{{api_docs_details}}

## 🔧 Configuration Files

### Primary Config Files
{{config_files_list}}

### Database Configuration
{{database_config}}

### Security Configuration
{{security_config}}

## ⚠️ Challenges & Considerations

### Current Architecture Challenges
{{architecture_challenges}}

### Performance Bottlenecks
{{performance_bottlenecks}}

### Security Considerations
{{security_considerations}}

### Scalability Considerations
{{scalability_notes}}

---

## 🔄 Ready for build-tech-docs

Este documento consolidado está otimizado para acelerar o processo do `/docs/build-tech-docs`:

✅ **Análise Estrutural Completa** - Detectado automaticamente como Node.js API  
✅ **Stack Identificado** - {{main_stack}}  
✅ **Arquitetura Mapeada** - {{architecture_pattern}} com {{framework}}  
✅ **Endpoints Catalogados** - {{endpoints_count}} endpoints com {{auth_method}}  
✅ **Database Design** - {{database_type}} com {{tables_count}} tabelas  
✅ **Performance Metrics** - Response times, throughput, database connections  
✅ **Challenges Identificados** - Bottlenecks e oportunidades de otimização  

**Próximo passo**: Use este documento como input para `/docs/build-tech-docs` para gerar a documentação técnica completa em 9 arquivos.
