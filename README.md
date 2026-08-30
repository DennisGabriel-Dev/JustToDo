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
