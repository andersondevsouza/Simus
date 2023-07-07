CREATE TABLE "cliente" (
  "id" serial PRIMARY KEY,
  "nome" varchar(50),
  "cpf" varchar(11),
  "status" char(1),
  "data_nascimento" date
);

CREATE TABLE "fornecedor" (
  "id" serial PRIMARY KEY,
  "nome_fantasia" varchar(50),
  "razao_social" varchar(50),
  "cnpj" varchar(14),
  "status" char(1)
);

CREATE TABLE "produto" (
  "id" serial PRIMARY KEY,
  "fornecedor_id" integer,
  "descricao" varchar(50),
  "preco_venda" numeric(10,2),
  "status" char(1)
);

CREATE TABLE "venda" (
  "id" serial PRIMARY KEY,
  "numero" integer,
  "cliente_id" integer,
  "data_hora" timestamp,
  "total" numeric(10,2),
  "status" char(1)
);

CREATE TABLE "venda_item" (
  "id" serial PRIMARY KEY,
  "venda_id" integer,
  "produto_id" integer,
  "quantidade" numeric(10,2),
  "preco_unitario" numeric(10,2),
  "total" numeric(10,2)
);

COMMENT ON COLUMN "cliente"."status" IS 'A = Ativo ou I = Inativo';

COMMENT ON COLUMN "fornecedor"."status" IS 'A = Ativo ou I = Inativo';

COMMENT ON COLUMN "produto"."status" IS 'A = Ativo ou I = Inativo';

COMMENT ON COLUMN "venda"."status" IS 'P = Pendente ou E = Efetivada';

ALTER TABLE "produto" ADD FOREIGN KEY ("fornecedor_id") REFERENCES "fornecedor" ("id");

ALTER TABLE "venda" ADD FOREIGN KEY ("cliente_id") REFERENCES "cliente" ("id");

ALTER TABLE "venda_item" ADD FOREIGN KEY ("venda_id") REFERENCES "venda" ("id");

ALTER TABLE "venda_item" ADD FOREIGN KEY ("produto_id") REFERENCES "produto" ("id");