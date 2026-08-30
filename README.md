# Just To Do

Ruby 3.3.3 · Rails 7.1.4 · PostgreSQL · Hotwire

## Rodar com Docker

1. Copie o env e gere uma `SECRET_KEY_BASE`:

```bash
cp .env.example .env
```

No `.env`, troque o valor por uma chave (por exemplo: `openssl rand -hex 64`).

2. Suba o app e o banco:

```bash
docker compose up --build
```

3. Abra [http://localhost:3000](http://localhost:3000)

Login de demonstração (criado pelo seed):

- e-mail: `demo@justtodo.dev`
- senha: `Demo1234`

Para recriar o banco e popular de novo:

```bash
docker compose run --rm web bundle exec rails db:reset
```

## Rodar sem Docker

1. Configure `config/database.yml` (ou as variáveis `DATABASE_HOST`, `DATABASE_USERNAME` e `DATABASE_PASSWORD`).
2. `bundle install`
3. `bin/rails db:prepare db:seed`
4. `bin/rails server`

## CI (GitHub Actions)

A cada push ou pull request na branch `main`/`master`, o workflow [`.github/workflows/ci.yml`](.github/workflows/ci.yml) roda:

1. **RSpec** — `db:prepare` + suite de testes (PostgreSQL 16)
2. **RuboCop** — lint com config Shopify + baseline em `.rubocop_todo.yml`

Rodar localmente (com Docker):

```bash
docker compose exec web bundle exec rubocop --parallel
docker compose exec -e RAILS_ENV=test web bundle exec rails db:prepare
docker compose exec -e RAILS_ENV=test web bundle exec rspec
```

## Deploy no Render

O projeto inclui um [Blueprint](https://render.com/docs/blueprint-spec) em [`render.yaml`](render.yaml) com:

- **Web Service** (Docker, stage `production` do Dockerfile)
- **PostgreSQL** (plano free)

### Passo a passo

1. Faça push do repositório para o GitHub.
2. No [Render Dashboard](https://dashboard.render.com/) → **New** → **Blueprint** → conecte o repo.
3. Aguarde o primeiro deploy. O entrypoint roda `db:prepare` automaticamente.
4. (Opcional) Para popular dados demo no primeiro deploy, adicione `RUN_SEEDS=true` nas env vars do serviço e redeploy. Depois pode remover.

**Se o deploy falhar com `key must be 16 bytes`:** no dashboard do serviço, vá em **Environment** e **apague** a variável `RAILS_MASTER_KEY` se existir (valor incorreto quebra o boot). Este app usa só `SECRET_KEY_BASE`.

Login demo (se rodou seed): `demo@justtodo.dev` / `Demo1234`

### Variáveis de ambiente (produção)

| Variável | Origem |
|---|---|
| `DATABASE_URL` | Postgres no Render (automático via Blueprint) |
| `SECRET_KEY_BASE` | Gerada pelo Render (automático) |
| `RAILS_SERVE_STATIC_FILES` | `true` (no Blueprint) |
| `RAILS_LOG_TO_STDOUT` | `true` (no Blueprint) |
| `RUN_SEEDS` | `true` só no primeiro deploy (opcional) |

O Render expõe `RENDER_EXTERNAL_URL`; o app usa isso para HTTPS e URLs do Devise.
