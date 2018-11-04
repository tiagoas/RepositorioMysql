
CREATE DATABASE Clinica;

CREATE table Cliente (
	idCliente int primary key,
    nome varchar (255),
    endereco varchar (255),
    bairro varchar (255), 
    cep varchar (9),
    cidade varchar (255),
    estado varchar (255),
    telefone varchar (255)
    );
    

drop table animal;

    CREATE table Animal (
	idAnimal int primary key,
    nome varchar (255),
    idade int,
    sexo varchar (255), 
    idEspecie int references Especie (idEspecie),
    idCliente int references Cliente (idCliente)
    );
    
    
    
	CREATE table Especie (
    idEspecie int primary key,
    descricao varchar (255),
    idAnimal int references Animal (idAnimal)
    );
    
    
    
		CREATE table Veterinario (
		idVeterinario int primary key,
		nome varchar (255),
		endereco varchar (255),
		telefone varchar (255)
		);
        


	CREATE table Tratamento (
    idTratamento int primary key,
    dataInicial varchar (10),
    dataFinal varchar (10),
    idAnimal int references Animal (idAnimal)
    );
    
    
    
	CREATE table Consulta (
    idConsulta int primary key,
    data varchar (10),
    historico varchar (255),
    idTratamento int references Tratamento (idTratamento),
    idVeterinario int references Veterinario (idVeterinario)
    
    );
    
    
    
	CREATE table Exame	(
    idExame int primary key,
    descricao varchar (255),
    idConsulta int references Consulta (idConsulta)
    );
    
    
    
    -- exercicio a 
    
    SELECT Cliente.nome , Animal.nome , Especie.descricao  from animal inner join cliente on cliente.idCliente = animal.idCliente inner join Especie on animal.idEspecie = Especie.idEspecie ; 
    
	-- exercicio b 
    
    SELECT count (idConsulta) from Consulta;
    
    -- exercicio c 
    
    SELECT distinc veterinario.idVeterinaio from Consulta inner join Veterinario on
    Veterinario.idVeterinario = consulta.idVeterinario ;
    
    -- exercicio d
    
    SELECT animal.nome from exame inner join Consulta on Consulta.idConsulta = Exame.idConsulta inner join Tratamento on Tratamento.idTratamento = Consulta.idTratamento inner join Animal on Animal.idAnimal = Tratamento.idAnimal;
    
    
    -- exercicio e
    
    SELECT Cliente.Nome, count (idAnimal) from Cliente inner join Animal on Cliente.idCliente = Animal.idCliente 
    
    -- exercicio f
    
    CREATE VIEW todas_consultas (nomeCliente, nomeAnimal, nomeVeterinario) AS  
    (SELECT cliente.nome, animal.nome, Veterinario.nome from Veterinario inner join Consulta on 
    consulta.idVeterinario = Veterinario.idVeterinario inner join Tratamento on 
    Tratamento.idTratamento = Consulta.idTratamento inner join Animal on Animal.idAnimal = Tratamento.idAnimal
    inner join Cliente on Cliente.idCliente = Animal.idCliente);
    
    -- exercicio g
    
    
    SELECT cliente.nome, animal.nome from todas_consultas where veterinario.nome = "fulano da silva" ;
    
    -- exercicio h
    
    CREATE view nao_finalizados (nomeCliente, nomeAnimal, dataInicial) AS
    (SELECT Cliente.nome , Animal.nome, Tratamento.dataInicial from Tratamento inner join Animal on
    Animal.idAnimal = Tratamento.idAnimal 
    inner join Cliente on Cliente.idCliente = Animal.idCliente where tratamento.dataFInal = NULL);
    
    
    -- exercicio i 
    
    SELECT Animal.nome from nao_finalizados where tratamento.dataInicial like "%09";
    
    
    
    
    --      -----------------------------------------------------------
     --      -----------------------------------------------------------
      --      -----------------------------------------------------------
       --      -----------------------------------------------------------
        --      -----------------------------------------------------------
         --      -----------------------------------------------------------
    
    