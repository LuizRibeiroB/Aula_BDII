CREATE Database semestre;

use semestre;

/*------------------------------------------------------------------------------------------*/

 CREATE TABLE empresa
 (
    empr_codigo INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    empr_nome VARCHAR(45)
    
);

INSERT INTO 
    empresa
    (
        empr_nome
    )
    VALUES
   
        ('Nestlé'),
        ('Seara'),
        ('Sadia'),
        ('Batavo')
   ;

/*------------------------------------------------------------------------------------------*/

 CREATE TABLE produtos
 (
    prod_codigo INT PRIMARY KEY AUTO_INCREMENT,
    prod_descricao VARCHAR(45) NOT NULL,
    prod_pr_compra FLOAT,
    prod_pr_venda FLOAT,
    prod_estoque1 INT,
    prod_empr_codigo INT NOT NULL,
    FOREIGN KEY (prod_empr_codigo)
        REFERENCES empresa (empr_codigo)
);   

INSERT INTO produtos
    (
    prod_descricao, 
    prod_pr_compra, 
    prod_pr_venda, 
    prod_estoque1, 
    prod_empr_codigo
    )
    VALUES 
        ('Chocolate Barra 200g','0.00','5.99',24,'1'),
        ('Salsicha Viena 500g','0.00','6.89',12,'2'),
        ('Bacon Pedaços 500g','0.00','10.89',12,'3'),
        ('Iogurte Integral 200ml','1.90','3.99',48,'4'),
		('Ovo Pascoa 350g','29.90','49.99',12,'1'),
        ('Salsicha Shwabell 400g','19.80','32.90',12,'2'),
        ('Barriga de Porco 500g','16.90','34.99',12,'3'),
        ('Iogurte Morango 200ml','1.90','3.99',48,'4')
   ;

/*------------------------------------------------------------------------------------------*/

CREATE TABLE estados
 (
    est_codigo INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    est_nome VARCHAR(45)
    
);

INSERT INTO estados
    (
    est_nome
    )
    VALUES 
        ('Paraná'),
        ('Santa Catarina'),
        ('Rio Grande do Sul'),
        ('São Paulo'),
        ('Rio de Janeiro')
   ;

/*------------------------------------------------------------------------------------------*/
CREATE TABLE cidades
    (
        cid_codigo INT NOT NULL AUTO_INCREMENT UNIQUE,
        cid_nome VARCHAR(45),
        cid_est_codigo INT NOT NULL,
        FOREIGN KEY (cid_Est_codigo)
        REFERENCES estados (est_codigo)
    );

INSERT INTO cidades
    (
        cid_nome,
        cid_est_codigo
    )
    VALUES 
        ('Curitiba', 1),
        ('Florianópolis',2),
        ('Porto Alegre', 3),
        ('São Paulo', 4),
        ('Rio de Janeiro', 5),
        ('Ponta Grossa', 1),
        ('Caçador', 2),
        ('Caxias', 3),
        ('Osasco', 4),
        ('Duque de Caxias', 5),
		('Colombo', 1),
        ('São José dos Pinhais',1),
        ('Araucária', 1),
        ('Pinhais', 1)
   ;

/*------------------------------------------------------------------------------------------*/

CREATE TABLE cargos
 (
    cargo_codigo INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    cargo_descricao VARCHAR(45) NOT NULL
);

INSERT INTO cargos
    (
        cargo_descricao
    )
    VALUES 
        ('Gerente'),
        ('Diretor'),
        ('Secretário'),
        ('Vendedor')        
   ;

/*------------------------------------------------------------------------------------------*/   

CREATE TABLE clientes
 (
    clie_codigo INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    clie_nome VARCHAR(45) NOT NULL,
    clie_cpf_cnpj VARCHAR(14) NOT NULL UNIQUE,
    clie_telefone VARCHAR(13),
    clie_logradouro VARCHAR(45) NOT NULL,
    clie_numero INT NOT NULL,
    clie_cid_codigo INT,
    FOREIGN KEY (clie_cid_codigo)
        REFERENCES cidades (cid_codigo)
 );

INSERT INTO clientes
    (
        clie_nome,
        clie_cpf_cnpj,
        clie_telefone,
        clie_logradouro,
        clie_numero,
        clie_cid_codigo
    )
    VALUES 
        ('João Alves', 05632532585 ,'41-88888-8888' ,  'Tv. da Lua' , 55 , 1 ),
        ('Ana Carolina Neves' , 04128855714 , '41-99999-9999' , 'Rua Pacheco Mendonça', 1545 , 2),
        ('Igreja Persbiteriana I' , 77883220000144 , '41-77777-7777' , 'Rua Epitácio Pessoa', 92, 3),
        ('Transportadora Speed Fast' , 16356535000265 , '41-66666-6666' , 'Marginal BR 116' , 5452, 9)                
   ;

/*------------------------------------------------------------------------------------------*/   

CREATE TABLE usuarios
 (
    usu_codigo INT PRIMARY KEY AUTO_INCREMENT UNIQUE,
    usu_nome VARCHAR(45) NOT NULL,
    usu_cpf VARCHAR(11) NOT NULL UNIQUE,
    usu_logradouro VARCHAR(45) NOT NULL,
    usu_numero INT NOT NULL,
    usu_cid_codigo INT,
    usu_cargo_codigo INT,
    FOREIGN KEY (usu_cid_codigo)
        REFERENCES cidades (cid_codigo),
    FOREIGN KEY (usu_cargo_codigo)
        REFERENCES cargos (cargo_codigo)        
 );

INSERT INTO usuarios
    (
        usu_nome,
        usu_cpf,
        usu_logradouro,
        usu_numero,
        usu_cid_codigo,
        usu_cargo_codigo
    )
    VALUES 
        ('Pedro Cunha', 58476692166 , 'Rua Tapajós' , 95 , 1 ,3),
        ('Maria da Cruz' , 22548837512 , 'Rua Manoel Ribas', 22 , 11,1),
        ('Jorge Muniz' , 14138875747 , 'Av. Dom Peperoni', 15, 14,4),
        ('Carol Dias' , 14552237889 , 'Rua Angelo da Nobrega' , 77, 13,2),                
        ('Luana Pinheiro' , 42558576924 , 'Rua Manoal da Rocha' , 155,1,3) 
   ;

/*------------------------------------------------------------------------------------------*/   
 
 CREATE TABLE vendas_usu
    (  
        vdausu_codigo INT AUTO_INCREMENT UNIQUE,
        vdausu_usu_codigo INT NOT NULL,
        vdausu_prod_codigo INT NOT NULL,
        vdausu_qtde INT NOT NULL,
        vdausu_vl_unit FLOAT NOT NULL,
        vdausu_vl_total FLOAT NOT NULL,
        vdausu_val_cargo ENUM('1','2','4') DEFAULT NULL,
        FOREIGN KEY (vdausu_usu_codigo)
            REFERENCES usuarios (usu_codigo),
         FOREIGN KEY (vdausu_prod_codigo)
            REFERENCES produtos (prod_codigo)
    );

INSERT INTO vendas_usu
    (
        vdausu_usu_codigo,
        vdausu_prod_codigo,
        vdausu_qtde,
        vdausu_vl_unit,
        vdausu_vl_total,
        vdausu_val_cargo
    )
    VALUES
        (2, 1 , 3 , 5.99 , 17.97 , 1),
        (3, 2 , 1 , 6.89 , 6.89 , 4),
        (4, 3 , 3 , 10.89 , 32.67 , 2),
        (2, 4 , 2 , 3.99 , 7.98 , 1),
        (3, 5 , 3 , 49.99 , 149.97 , 4),
        (4, 6 , 1 , 32.90 , 32.90 , 2)
    ;
        
/*------------------------------------------------------------------------------------------*/   
 CREATE TABLE vendas_clientes
    (  
        vdacli_codigo INT AUTO_INCREMENT UNIQUE,
        vdacli_clie_codigo INT,
        vdacli_prod_codigo INT NOT NULL,
        vdacli_qtde INT NOT NULL,
        vdacli_vl_unit FLOAT NOT NULL,
        vdacli_vl_total FLOAT NOT NULL,
         FOREIGN KEY (vdacli_prod_codigo)
            REFERENCES produtos (prod_codigo)
    );

INSERT INTO vendas_clientes
    (
        vdacli_clie_codigo,
        vdacli_prod_codigo,
        vdacli_qtde,
        vdacli_vl_unit,
        vdacli_vl_total
    )
    VALUES
        (1, 6, 1 , 5.99 , 5.99),
        (2, 5, 2, 6.89 , 13.79),
        (3, 4, 1 , 10.89 , 10.89),
        (4, 3, 3 , 3.99 , 11.97),
        (1, 2, 1 , 49.99 , 49.99),
        (2, 6, 1 , 5.99 , 5.99),
        (3, 5, 2, 6.89 , 13.79),
        (4, 4, 1 , 10.89 , 10.89),
        (1, 3, 3 , 3.99 , 11.97),
        (2, 2, 1 , 49.99 , 49.99),
        (2, 5, 2, 6.89 , 13.79),
        (3, 4, 1 , 10.89 , 10.89),
        (4, 3, 3 , 3.99 , 11.97),
        (1, 2, 1 , 49.99 , 49.99),
        (2, 6, 1 , 5.99 , 5.99),
        (3, 5, 2, 6.89 , 13.79),
        (4, 4, 1 , 10.89 , 10.89),
        (1, 3, 3 , 3.99 , 11.97),
        (2, 2, 1 , 49.99 , 49.99),
        (4, 2, 1 , 49.99 , 49.99),
        (3, 2, 1 , 49.99 , 49.99),
        (3, 1, 1 , 32.90 , 32.90)
    ;

/*------------------------QUERYS-----------------------------------------*/   

/*1 - Query traz o nome do cargo, o nome do usuário, o nome do produto - trazer todos.*/

SELECT 
    usuarios.usu_nome AS Nome_usuário, 
    cargos.cargo_descricao AS Cargos, 
    produtos.prod_descricao AS Produto_Comprado
    
        FROM 
            usuarios, vendas_usu, produtos,cargos
        WHERE 
            vendas_usu.vdausu_usu_codigo = usuarios.usu_codigo
        AND
            vendas_usu.vdausu_prod_codigo = produtos.prod_codigo
        AND
            usuarios.usu_cargo_codigo = cargos.cargo_codigo
;


/*2 - Query traz o nome do cargo, o nome do usuário, o nome do produto - trazer para o nome de um produto específico.*/

SELECT 
    usuarios.usu_nome AS Nome_usuário, 
    cargos.cargo_descricao AS Cargos, 
    produtos.prod_descricao AS Produto_Comprado
    
        FROM 
            usuarios, vendas_usu, produtos,cargos
        WHERE 
            vendas_usu.vdausu_usu_codigo = usuarios.usu_codigo
        AND
            vendas_usu.vdausu_prod_codigo = produtos.prod_codigo
        AND
            usuarios.usu_cargo_codigo = cargos.cargo_codigo
        AND 
            vendas_usu.vdausu_prod_codigo = 5    
;


/*3 - Query traz o nome do cliente, a empresa do cliente, o nome do produto que o cliente consome, o telefone do cliente
 e a quantidade do produto em estoque - trazer todos.*/

SELECT 
    clientes.clie_codigo AS Codigo_Cliente,
    clientes.clie_nome AS Nome_Cliente, 
    clientes.clie_telefone AS Fone_Cliente, 
    produtos.prod_descricao AS Produto_Comprado,
    vendas_clientes.vdacli_codigo AS ID_da_Venda,
    produtos.prod_estoque1 AS Estoque_Atual,
    empresa.empr_nome AS Empresa
        FROM 
            clientes, vendas_clientes, produtos, empresa
        WHERE 
            clientes.clie_codigo = vendas_clientes.vdacli_clie_codigo 
        AND
            vendas_clientes.vdacli_prod_codigo = produtos.prod_codigo 
        AND
            produtos.prod_empr_codigo = empresa.empr_codigo  
;

/*4 - Query traz o nome do cliente, a empresa do cliente, o nome do produto que o cliente consumo, 
o telefone do cliente e a quantidade do produto em estoque - trazer para o nome de um cliente específico (pelo nome).*/


SELECT 
    clientes.clie_codigo AS Codigo_Cliente,
    clientes.clie_nome AS Nome_Cliente, 
    clientes.clie_telefone AS Fone_Cliente, 
    produtos.prod_descricao AS Produto_Comprado,
    vendas_clientes.vdacli_codigo AS ID_da_Venda,
    produtos.prod_estoque1 AS Estoque_Atual,
    empresa.empr_nome AS Empresa
        FROM 
            clientes, vendas_clientes, produtos, empresa
        WHERE 
            clientes.clie_codigo = vendas_clientes.vdacli_clie_codigo 
        AND
            vendas_clientes.vdacli_prod_codigo = produtos.prod_codigo 
        AND
            produtos.prod_empr_codigo = empresa.empr_codigo 
        AND 
            clientes.clie_nome = 'Ana Carolina Neves'  
;

/*5 - Query traz o nome do cliente, a empresa do cliente, o nome do produto que o cliente consome, o telefone do 
cliente e a quantidade do produto em estoque - trazer para um conjunto de clientes (veja in) pelo nome - adicione 2.*/

SELECT 
    clientes.clie_codigo AS Codigo_Cliente,
    clientes.clie_nome AS Nome_Cliente, 
    clientes.clie_telefone AS Fone_Cliente, 
    produtos.prod_descricao AS Produto_Comprado,
    vendas_clientes.vdacli_codigo AS ID_da_Venda,
    produtos.prod_estoque1 AS Estoque_Atual,
    empresa.empr_nome AS Empresa
        FROM 
            clientes, vendas_clientes, produtos, empresa
        WHERE 
            clientes.clie_codigo = vendas_clientes.vdacli_clie_codigo 
        AND
            vendas_clientes.vdacli_prod_codigo = produtos.prod_codigo 
        AND
            produtos.prod_empr_codigo = empresa.empr_codigo 
        AND 
            clientes.clie_nome IN ('Ana Carolina Neves' , 'Transportadora Speed Fast' )
;

/*6 - Query traz o nome do cliente, a empresa do cliente, o nome do produto que o cliente consumo, o telefone do 
cliente e a quantidade do produto em estoque - trazer para um conjunto de clientes (veja in) pelo nome - adicione 2 com limite de 3 registros*/


SELECT 
    clientes.clie_codigo AS Codigo_Cliente,
    clientes.clie_nome AS Nome_Cliente, 
    clientes.clie_telefone AS Fone_Cliente, 
    produtos.prod_descricao AS Produto_Comprado,
    vendas_clientes.vdacli_codigo AS ID_da_Venda,
    produtos.prod_estoque1 AS Estoque_Atual,
    empresa.empr_nome AS Empresa
        FROM 
            clientes, vendas_clientes, produtos, empresa
        WHERE 
            clientes.clie_codigo = vendas_clientes.vdacli_clie_codigo 
        AND
            vendas_clientes.vdacli_prod_codigo = produtos.prod_codigo 
        AND
            produtos.prod_empr_codigo = empresa.empr_codigo 
        AND 
            clientes.clie_nome IN ('Ana Carolina Neves' , 'Transportadora Speed Fast' )
        limit 3    
;

/*7 - Query traz o nome do cliente, a empresa do cliente, o nome do produto que o cliente consumo, o telefone do cliente e a quantidade 
do produto em estoque - trazer para um conjunto de clientes (veja in) pelo nome - adicione 2 com a ordenação orientada pela quantidade
de produtos sendo essa descendente.*/

SELECT 
    clientes.clie_codigo AS Codigo_Cliente,
    clientes.clie_nome AS Nome_Cliente, 
    clientes.clie_telefone AS Fone_Cliente, 
    produtos.prod_descricao AS Produto_Comprado,
    vendas_clientes.vdacli_qtde AS Quant_Compra,
    vendas_clientes.vdacli_codigo AS ID_da_Venda,
    produtos.prod_estoque1 AS Estoque_Atual,
    empresa.empr_nome AS Empresa
        FROM 
            clientes, vendas_clientes, produtos, empresa
        WHERE 
            clientes.clie_codigo = vendas_clientes.vdacli_clie_codigo 
        AND
            vendas_clientes.vdacli_prod_codigo = produtos.prod_codigo 
        AND
            produtos.prod_empr_codigo = empresa.empr_codigo 
        AND 
            clientes.clie_nome IN ('Ana Carolina Neves' , 'Transportadora Speed Fast' )
        ORDER BY
            vendas_clientes.vdacli_qtde 
            DESC
;

/*8 - Query traz o nome do cliente, a empresa do cliente, o nome do produto que o cliente consumo, o telefone do cliente e a 
quantidade do produto em estoque - trazer para um conjunto de clientes (veja in) pelo nome - adicione 2 com a ordenação 
orientada pelo preço de compra (do maior para o menor).*/

SELECT 
    clientes.clie_codigo AS Codigo_Cliente,
    clientes.clie_nome AS Nome_Cliente, 
    clientes.clie_telefone AS Fone_Cliente, 
    produtos.prod_descricao AS Produto_Comprado,
    vendas_clientes.vdacli_qtde AS Quant_Compra,
    vendas_clientes.vdacli_vl_unit AS Preço_Unit,
    vendas_clientes.vdacli_vl_total AS Valor_Total,
    vendas_clientes.vdacli_codigo AS ID_da_Venda,
    produtos.prod_estoque1 AS Estoque_Atual,
    empresa.empr_nome AS Empresa
        FROM 
            clientes, vendas_clientes, produtos, empresa
        WHERE 
            clientes.clie_codigo = vendas_clientes.vdacli_clie_codigo 
        AND
            vendas_clientes.vdacli_prod_codigo = produtos.prod_codigo 
        AND
            produtos.prod_empr_codigo = empresa.empr_codigo 
        AND 
            clientes.clie_nome IN ('Ana Carolina Neves' , 'Transportadora Speed Fast' )
        ORDER BY
            vendas_clientes.vdacli_vl_total
            DESC
;
