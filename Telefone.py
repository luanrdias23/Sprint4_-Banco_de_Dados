import random

def generate_phone_data(user_id):
    ddi = random.randint(1, 100)
    ddd = random.randint(1, 100)
    number = random.randint(1000000000, 9999999999)
    phone_type = random.choice(['Comercial', 'Residencial', 'Recado', 'Celular'])
    status = random.choice(['A', 'I'])  # Aleatoriamente ativo (A) ou inativo (I)

    sql_insert = f"INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, {user_id}, {ddi}, {ddd}, {number}, '{phone_type}', '{status}');"
    return sql_insert

# Gerar 50 telefones para usuários diferentes
for user_id in range(1, 51):
    sql_insert = generate_phone_data(user_id)
    print(sql_insert)
