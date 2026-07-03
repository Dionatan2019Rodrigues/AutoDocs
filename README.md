# AutoDocs

Sistema desenvolvido para automatizar a geração de documentos institucionais relacionados a projetos e convênios da **UFSM**. A plataforma centraliza o preenchimento de informações administrativas, financeiras e operacionais por meio de formulários, gerando automaticamente documentos em PDF padronizados conforme os modelos exigidos pela Coordenadoria de Projetos (COPROC).

Atualmente o projeto encontra-se na etapa de pesquisa e validação de ferramentas **self-hosted** para criação de formulários, armazenamento de dados e integração com um banco de dados IBM DB2.

---

# Tecnologias

- Node.js
- TypeScript
- Docker
- Docker Compose
- Axios
- Dotenv

Ferramentas avaliadas:

- Baserow
- Formbricks
- Typebot

---

# Pré-requisitos

Antes de executar o projeto é necessário possuir instalado:

- Git
- Docker Desktop
- Node.js (LTS)
- npm

Após instalar o Docker Desktop, certifique-se de que ele está em execução antes de continuar.

---

# Estrutura do projeto

```text
AutoDocs
│
├── providers
│   ├── baserow
│   │   ├── docker-compose.yaml
│   │
│   ├── formbricks
│   │   ├── cube
│   │   │   ├── cube.js
│   │   │   ├── schema
│   │   │   │   ├── FeedbackRecords.js
│   │   ├── .env
│   │   ├── .env.example
│   │   └── docker-compose.yaml
│   │
│   └── typebot
│       ├── .env
│       ├── .env.example
│       └── docker-compose.yaml
│
├── src
│   ├── baserow
│   │   ├── index.ts
│   ├── formbricks
│   ├── typebot
│
├── database
│   ├── data-base-v1.png
│   ├── data-base-v2.png
│   ├── README-db.md
│   ├── script.sql
│
├── .env
├── .env.example
├── .gitattributes
├── .gitignore
├── package-lock.json
├── package.json
├── README.md
└── tsconfig.json
```

---

# Instalação

Clone o repositório:

```bash
git clone <URL_DO_REPOSITORIO>
```

Entre na pasta:

```bash
cd AutoDocs
```

Instale as dependências:

```bash
npm install
```

---

# Configuração das variáveis de ambiente

Cada provider possui seu próprio arquivo `.env`.

Copie o arquivo `.env.example` para `.env` em cada provider.

Exemplo:

```text
providers/
    formbricks/
        .env

    typebot/
        .env
```

Preencha as variáveis de acordo com sua instalação.

---

# Docker Desktop

Abra o Docker Desktop e aguarde até que ele esteja completamente inicializado.

Verifique se o Docker está funcionando:

```bash
docker ps
```

---

# Executando o Baserow

Entre na pasta:

```bash
cd providers/baserow
```

Suba o container:

```bash
docker compose up -d
```

Verifique se o container iniciou:

```bash
docker ps
```

Acesse:

```
http://localhost
```

Para interromper:

```bash
docker compose down
```

---

# Executando o Formbricks

Entre na pasta:

```bash
cd providers/formbricks
```

Suba os containers:

```bash
docker compose up -d
```

Verifique:

```bash
docker ps
```

Acesse:

```
http://localhost:3000
```

Para interromper:

```bash
docker compose down
```

---

# Executando o Typebot

Entre na pasta:

```bash
cd providers/typebot
```

Suba os containers:

```bash
docker compose up -d
```

Verifique:

```bash
docker ps
```

Builder:

```
http://localhost:8080
```

Viewer:

```
http://localhost:8081
```

Para interromper:

```bash
docker compose down
```

> **Observação:** O Typebot necessita de um provedor de autenticação (OAuth/OpenID) para acesso ao Builder. Para fins de desenvolvimento foi utilizado o GitHub OAuth.

---

# Portas utilizadas

| Ferramenta | Porta |
|------------|------:|
| Baserow | 80 |
| Formbricks | 3000 |
| Typebot Builder | 8080 |
| Typebot Viewer | 8081 |

Como cada ferramenta utiliza uma porta diferente, todas podem permanecer executando simultaneamente.

---

# Executando os scripts

Após iniciar o provider desejado, execute na raiz do repositório o script correspondente:

### Baserow

```bash
npm run baserow
```

### Formbricks

```bash
npm run formbricks
```

### Typebot

```bash
npm run typebot
```

---

# Parando todos os containers

Caso deseje interromper todas as ferramentas:

```bash
docker compose down
```

Execute o comando dentro da pasta do provider correspondente.

---

# Atualizando as imagens

Para baixar versões mais recentes das imagens Docker:

```bash
docker compose pull
```

Em seguida:

```bash
docker compose up -d
```

---

# Verificando os containers

Containers em execução:

```bash
docker ps
```

Todos os containers:

```bash
docker ps -a
```

Volumes:

```bash
docker volume ls
```

Logs:

```bash
docker compose logs
```

Logs em tempo real:

```bash
docker compose logs -f
```

---

# Observações

- Cada provider possui seu próprio ambiente Docker.
- Cada provider possui seu próprio arquivo `.env`.
- Os dados persistentes ficam armazenados em volumes Docker.
- O projeto utiliza Docker Compose para facilitar a reprodução do ambiente de desenvolvimento.
- O diretório `database/` é compartilhado entre todos os providers, armazenando scripts SQL e demais arquivos relacionados à modelagem do banco de dados.

---

# Autor

Dionatan Eduardo Correa Rodrigues