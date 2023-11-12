import random

# Lista de IDs de logradouro existentes
ids_logradouro = list(range(1, 47))

# Função para gerar números de logradouro e complementos aleatórios
def gerar_nr_complemento():
    nr_logradouro = random.randint(1, 9999)
    ds_complemento_numero = f"'APTO {random.randint(1, 100)}'" if random.choice([True, False]) else 'NULL'
    

    return nr_logradouro, ds_complemento_numero

# Lista para armazenar instruções SQL INSERT
sql_statements = []

# Gerar instruções SQL INSERT
for i in range(1, 1081):
    id_usuario = i
    id_logradouro = random.choice(ids_logradouro)
    id_end_usuario = i
    nr_logradouro, ds_complemento_numero = gerar_nr_complemento()
    ds_ponto_referencia = f"'Ponto de referencia {i}'" if random.choice([True, False]) else 'NULL'


    sql_statement = f'''
    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES ({id_usuario}, {id_logradouro}, {id_end_usuario}, {nr_logradouro}, {ds_complemento_numero}, {ds_ponto_referencia});
    '''
    sql_statements.append(sql_statement)

# Imprimir as instruções SQL
for statement in sql_statements:
    print(statement)
