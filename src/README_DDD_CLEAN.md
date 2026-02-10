# Exemplo de DDD + Clean Architecture

Este exemplo organiza o módulo aviário em quatro camadas:

- **domain**: regras de negócio puras (entidades, value objects, serviços e exceções).
- **application**: casos de uso e portas (interfaces) para acesso a dados.
- **infrastructure**: implementação concreta de persistência (FireDAC/Firebird).
- **presentation**: forms/controladores que orquestram entradas e saídas.

## Dependências (regra da arquitetura limpa)

As dependências sempre apontam para dentro:

`presentation -> application -> domain`

`infrastructure -> application (+ domain quando necessário)`

O `domain` não conhece nenhuma outra camada.

## Exemplo de fluxo (Registrar Pesagem)

1. A form `uPesagem` recebe os dados da UI e cria `TRegistrarPesagemDTO`.
2. A form chama `TRegistrarPesagemUseCase.Executar`.
3. O use case instancia a entidade `TPesagem` (validação de regra no domínio).
4. O use case persiste a entidade através de `IPesagemRepository`.
5. A implementação real (`TPesagemRepositoryFD`) fica em `infrastructure`.

## Composição

`presentation/composition/Container.pas` monta as dependências:

- cria conexão Firebird,
- instancia repositórios concretos,
- injeta dependências nos use cases.

Essa abordagem facilita testes, manutenção e evolução do sistema.
