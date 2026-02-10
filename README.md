# 🐔 Avaliação Técnica – Sistema de Controle Aviário

Sistema desenvolvido em **Delphi (VCL)** utilizando **Firebird 4.0** como banco de dados.

O projeto simula um módulo de controle de granjas para gestão de:

- Cadastro de Lotes
- Lançamento de Pesagens
- Lançamento de Mortalidade
- Consulta consolidada do lote
- Indicador visual de saúde do lote (verde, amarelo e vermelho)

---

# 📌 Requisitos

Para executar o projeto é necessário:

- Windows 64 bits
- Delphi (VCL)
- Firebird 4.0 (64 bits)

---

# 🔥 Instalação do Firebird

1. Instale o **Firebird 4.0 (64 bits)**.
2. Após a instalação, verifique se o seguinte arquivo existe:

C:\Program Files\Firebird\Firebird_4_0\fbclient.dll

---

# ⚙️ Configuração Obrigatória no Delphi (FireDAC)

O projeto utiliza o driver Firebird via **FireDAC**.

Configure o componente:

TFDPhysFBDriverLink

Propriedade:

VendorLib = C:\Program Files\Firebird\Firebird_4_0\fbclient.dll

Isso garante que o Delphi utilize corretamente o cliente Firebird 4.0.

---

# 🗄️ Criação do Banco de Dados

Os scripts estão localizados na pasta:

database/

Execute na seguinte ordem:

1. 01_tables.sql  
2. 02_sequences.sql  
3. 05_exceptions.sql  
4. 03_procedures_pesagem.sql  
5. 04_procedure_mortalidade.sql  

Os scripts podem ser executados via:

- DBeaver
- IBExpert
- FlameRobin
- isql

Após a execução, o banco estará estruturado corretamente.

---

# 🔌 Configuração da Conexão

No DataModule (uDmLoteAves), configure:

DriverID = FB  
User_Name = SYSDBA  
Password = (definida na instalação do Firebird)  
Database = Caminho do banco criado  

Exemplo:

C:\Banco\AvaliacaoAviario.fdb

---

# ▶️ Execução

1. Abra o arquivo AvaliacaoAviario.dproj no Delphi.
2. Verifique se o VendorLib está configurado corretamente.
3. Compile o projeto.
4. Execute.

---

# 📊 Funcionalidades do Sistema

## 🐔 Cadastro de Lote (uLoteAves)
- Cadastro de novos lotes com:
  - Descrição
  - Data de entrada
  - Quantidade inicial de aves
- O peso médio geral do lote é recalculado automaticamente via Stored Procedure,
  utilizando média ponderada baseada na quantidade pesada.

---

## ⚖️ Lançamento de Pesagem (uPesagem)
- Seleção do lote via Lookup.
- Validação de lote selecionado.
- Validação de quantidade pesada (> 0).
- Validação de peso médio (> 0).
- Inserção realizada exclusivamente via Stored Procedure.
- Recalculo automático do peso médio geral do lote.
- Exibição das pesagens vinculadas ao lote selecionado.

---

## 💀 Lançamento de Mortalidade (uMortalidade)
- Seleção do lote via Lookup.
- Inserção realizada via Stored Procedure.
- Validação para impedir que a mortalidade acumulada ultrapasse a quantidade inicial do lote.
- Cálculo automático do percentual acumulado de mortalidade.
- Atualização dinâmica do indicador visual de saúde:

  - 🟢 Verde: menor que 5%
  - 🟡 Amarelo: entre 5% e 10%
  - 🔴 Vermelho: acima de 10%

- Exibição das mortalidades vinculadas ao lote selecionado.

---

## 📈 Controle e Consulta Consolidada (uControleLotes)

Tela responsável pela visualização consolidada de cada lote.

Funcionalidades:

- Seleção de lote via Lookup.
- Exibição consolidada em grid contendo:
  - ID do lote
  - Descrição
  - Quantidade inicial
  - Total pesado
  - Total de aves mortas
  - Percentual de mortalidade

A consulta utiliza agregações no banco de dados para apresentar os totais de forma correta e consistente, evitando duplicidade de somas.

Essa tela permite uma visão gerencial do desempenho do lote.

---

# 🧠 Observações Técnicas

- A lógica crítica de validação está centralizada no banco de dados através de Stored Procedures.
- A aplicação utiliza FireDAC para acesso a dados.
- Separação de responsabilidades entre interface, domínio e acesso a dados.
- Os dados são carregados dinamicamente conforme o lote selecionado.
- O projeto não inclui o arquivo .fdb por boas práticas, sendo fornecidos apenas os scripts SQL para criação da estrutura.

---

# 🏗️ Arquitetura

O projeto foi estruturado em camadas:

- Forms → Interface gráfica (VCL)
- DataModule → Acesso a dados (FireDAC)
- Domain → Representação das entidades de negócio e validações básicas
- Banco de Dados → Regras críticas centralizadas via Stored Procedures

Essa organização visa:

- Separação de responsabilidades
- Melhor manutenção
- Clareza estrutural
- Maior segurança das regras de negócio

---

Desenvolvido como avaliação técnica simulando um sistema de gestão avícola.


## 🧩 Exemplo prático aplicando DDD + Clean Architecture

Abaixo está um exemplo de separação por camadas usando o cenário de **registro de mortalidade**:

- **Domain (entidades + regras de negócio):**
  - `TMortalidade` valida os dados de entrada (`Validar`).
  - `TLoteAves` calcula percentual de mortalidade (`CalcularPercentualMortalidade`).
- **Application (caso de uso):**
  - `TRegistrarMortalidadeUseCase` orquestra a regra de negócio sem depender de FireDAC ou VCL.
- **Infra (detalhes externos):**
  - `TLoteAvesRepositoryFD` implementa a interface do repositório usando FireDAC/Stored Procedure.

Fluxo resumido:

1. A tela (Form) coleta os dados e chama o **Use Case**.
2. O **Use Case** valida entidades de domínio e calcula o percentual.
3. O **Use Case** usa a abstração `ILoteAvesRepository` para persistir.
4. A implementação concreta no **Infra** executa SQL/SP no Firebird.

Estrutura de exemplo criada:

- `src/domain/uLoteAvesRepository.pas` (porta de saída / interface)
- `src/application/uRegistrarMortalidadeUseCase.pas` (caso de uso)
- `src/infra/uLoteAvesRepositoryFD.pas` (adaptador FireDAC)

Esse formato facilita testes, manutenção e evolução, pois as regras centrais ficam protegidas de mudanças em UI e banco.

---



## ✅ Exemplo mais próximo de DDD + Clean Architecture (estrutura sugerida)

Foi adicionada uma estrutura de referência em `src/` seguindo o modelo solicitado:

```text
src/
  domain/
    entities/
      Lote.pas
      Pesagem.pas
      Mortalidade.pas
    valueobjects/
      Percentual.pas
    services/
      IndicadorSaudeService.pas
    exceptions/
      DomainException.pas

  application/
    ports/
      ILoteRepository.pas
      IPesagemRepository.pas
      IMortalidadeRepository.pas
    usecases/
      RegistrarPesagemUseCase.pas
      RegistrarMortalidadeUseCase.pas
      ObterResumoLoteUseCase.pas
    dto/
      RegistrarPesagemDTO.pas
      RegistrarMortalidadeDTO.pas
      ResumoLoteDTO.pas

  infrastructure/
    persistence/
      FirebirdConnectionFactory.pas
      Repositories/
        PesagemRepositoryFD.pas
        MortalidadeRepositoryFD.pas
        LoteRepositoryFD.pas

  presentation/
    forms/
      uPesagem.pas
      uMortalidade.pas
      uControleLotes.pas
    composition/
      Container.pas
```

### Fluxo de dependência (Clean Architecture)

- Presentation -> Application (DTO + UseCases)
- Application -> Domain (entidades e regras)
- Application -> Ports (interfaces)
- Infrastructure -> Ports (implementações FireDAC)

Assim, as regras centrais permanecem isoladas de detalhes de UI e banco.

---
