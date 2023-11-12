import random
from faker import Faker

# Inicializa o Faker
fake = Faker('pt_BR')

# Lista para armazenar instruções SQL INSERT
sql_statements_usuarios = []

# Gerar instruções SQL INSERT para 46 usuários
for i in range(1, 47):
    nr_cpf = fake.random_int(min=10000000000, max=99999999999, step=1)
    nm_usuario = fake.name()
    dt_nascimento = fake.date_of_birth(minimum_age=18, maximum_age=90).strftime('%Y-%m-%d')
    nm_rg = fake.random_number(digits=9)
    fl_sexo_biologico = random.choice(['M', 'F'])
    ds_email = fake.email()
    ds_senha = fake.password(length=8)

    sql_statement_usuario = f'''
    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES ({i}, {nr_cpf}, '{nm_usuario}', TO_DATE('{dt_nascimento}', 'YYYY-MM-DD'), '{nm_rg}', '{fl_sexo_biologico}', '{ds_email}', '{ds_senha}');
    '''
    sql_statements_usuarios.append(sql_statement_usuario)

# Imprimir as instruções SQL
for statement in sql_statements_usuarios:
    print(statement)
