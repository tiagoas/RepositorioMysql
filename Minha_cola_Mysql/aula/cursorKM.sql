open meuCursor;

-- Looping de esxecução do cursor

while existe_mais_linhas < > 1 do
FETCH meuCursor INTO kilometros;

-- Soma a kilometragem do registro atual com o total acumulado
SET total_de_kilometros = total_de_kilometros + kilometros;

-- retorna para a primeira linha do loop
END while;
close meuCursor;
--Sentando a variável com o resultado final
SET resultado = total_de_kilometros;

END;

DELIMITER;

CALL Somakilometragem(@variavel_temporario);
SELECT @variavel_temporario;