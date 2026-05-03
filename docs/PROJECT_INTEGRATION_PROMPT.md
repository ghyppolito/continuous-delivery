# Guia de Integração de Projetos

Este documento contém o **Master Prompt** que você pode utilizar em qualquer assistente de IA (como o Antigravity, Claude ou ChatGPT) para adequar seus projetos existentes e integrá-los com as ferramentas de avaliação deste repositório.

## O Master Prompt

Copie e cole o texto abaixo no chat do seu projeto:

---

> **Contexto:** Tenho um repositório central de infraestrutura de CI/CD que contém as ferramentas: SonarQube, Gitleaks, Trivy, DefectDojo, Dependency-Check e Hadolint, todos gerenciados via Docker Compose e um Makefile central.
>
> **Tarefa:** Como um Engenheiro de DevOps Senior, analise este projeto atual e crie os scripts e configurações necessários para integrá-lo com esse repositório central de ferramentas.
>
> **Requisitos do Script:**
> 1. **Detecção de Stack**: Identifique as tecnologias usadas (ex: Node.js, Python, Java) para configurar os scanners corretamente.
> 2. **Configuração de Scanner**:
>    - Crie um arquivo `sonar-project.properties` com as chaves e caminhos de exclusão adequados.
>    - Crie um diretório `scripts/` e um script `ci-scan.sh`.
> 3. **Lógica de Execução**: O script `ci-scan.sh` deve:
>    - Aceitar o caminho absoluto do repositório `continuous-delivery` como variável de ambiente ou argumento.
>    - Executar o Gitleaks, Trivy e Dependency-Check apontando para o código deste projeto.
>    - Enviar os resultados para o SonarQube.
> 4. **Integração com DefectDojo**: Adicione uma função no script que use `curl` para fazer o upload dos relatórios gerados (JSON/XML) para a API do DefectDojo.
> 5. **Documentação Local**: Crie um arquivo `SCAN_INSTRUCTIONS.md` no projeto atual explicando como o desenvolvedor deve rodar a varredura localmente.
>
> **Saída Esperada:** A estrutura de arquivos pronta e o código do script de automação comentado.

---

## Como usar este Guia

1.  **Abra o projeto que deseja avaliar.**
2.  **Abra o chat da sua IA favorita.**
3.  **Cole o prompt acima.**
4.  **Ajuste os caminhos**: Quando a IA gerar os scripts, certifique-se de que o caminho para o repositório `continuous-delivery` está correto no seu ambiente local.
5.  **Configure as chaves**: Lembre-se de fornecer os tokens do SonarQube e do DefectDojo no arquivo `.env` que será gerado no seu projeto.

## Benefícios
- **Padronização**: Todos os seus projetos seguirão o mesmo fluxo de análise.
- **Visão Centralizada**: Todos os bugs e vulnerabilidades serão reportados no mesmo dashboard do DefectDojo.
- **Agilidade**: Você não precisa configurar o Docker Compose manualmente em cada projeto novo; apenas "consome" a infraestrutura central.
