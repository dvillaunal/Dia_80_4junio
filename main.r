## ---- eval=FALSE, include=TRUE-------------------------------------------------------
## "Protocolo:
##  1. Daniel Felipe Villa Rengifo
##  2. Lenguaje: R
##  3. Tema: Matrices de Confusión y Diagramas de Mosaico
##  4. Fuentes:
##     https://bookdown.org/jboscomendoza/r-principiantes4/graficos-de-mosaico.html"


## ------------------------------------------------------------------------------------
"La base de datos se basa en notas de 4000 estudiantes, donde las dos ultimas columnas arrogan: 1. La nota real | 2. El valor predicho (todas dos tiene aspectos cualitativos = \"Low\", \"Medium\", \"High\")"


## ------------------------------------------------------------------------------------
# Cargamos la base de datos:
cp <- read.csv(file = "college-perf.csv")

# La variable Perf = Nota real
# la variable Pred = NOTA REDICHA

# Ahora transformaremos las dos columnas en datos que tengan sentido, ya que necistamos decirle a R que:

# LOW < MEDIUM < HIGH

# le diremos a R que quiero estos tres factores o niveles (ya que automaticamente R agrega los string que tienen muchas repeticiones como factores)

cp$Perf <- ordered(cp$Perf, levels = c("Low", "Medium", "High"))

# Hicimos un Ranking de las notas

cp$Pred <- ordered(cp$Pred, levels = c("Low", "Medium", "High"))

# SI vemos las columnas veremos que nos arrogara la clase ordered factor:
str(cp$Pred, cp$Perf)


# Ahora genereamos una tabla de doble entrada para lo predicho y lo arrogado:
#Daremos tambien una denominación, (nombres a la columna y fila)

tabla <- table(cp$Perf, cp$Pred, dnn = c("Actual", "Predicho"))

write.table(tabla, file = "TablaFreqAbs.txt")
print(tabla)

"De esto podemos decir, que para las personas que sacaron nota baja, el modelo predijo = que 182 personas (el modelo se equivoco en 182 casos de 1332) no lo harian (suma de la premra fila medium y high)"

# Tenemos que para un caso en concreto si un modelo se equivoca pocas veces de muchas eces realizado, diremos que este modelo esta bien. depende tambien del numero de datos

# En vez de las frecuencias absolutas, podemos mostrar las proporciones o porcentajes:

prop_tabla <- prop.table(tabla)

write.table(prop_tabla, file = "TablaProp.txt")
# 100% = 1.0
print(prop_tabla)


# Esta tabla (a continuación) esta organiza por filas, es decir si sumamos en horizontal hallaremos la cantida de estuddiantes que sacaron Baja, media o alta nota.

# Ahora vamos a redondedar la cuestión anterior para que prop.table no sace muchos decimales sino dos, además lo convertiremos a porcentaje:

porcentaje_tabla1 <- round(prop.table(tabla, 1)*100, digits = 2)

write.table(porcentaje_tabla1, file = "TablaPoncertaje1.txt")

print(porcentaje_tabla1)

# Pero notamos algo, por filas ponemos en entredicho el modelo, entoncces lo haremos por columnas

porcentaje_tabla2 <- round(prop.table(tabla, 2)*100, digits = 2)

write.table(porcentaje_tabla2, file = "TablaPoncertaje2.txt")

# Ahora lo que hacemos es poner en entredicho al estudiante

"Entonce spodemos decir, si el modelo ha dicho [Low], yo puedo garantizar que el 85% de los estudiantes tendran nota baja"

# Normalizamos por columnas en otras maneras

print(porcentaje_tabla2)


# Todas las tablas dadas anteriormente son tablas de confusión


## ------------------------------------------------------------------------------------
# Graficamos y exportamos el barplot para representar los datos
png(filename = "barplot.png")

barplot(tabla, legend.text = T,
        xlab = "Nota Predecida por el Modelo")

dev.off()

# Podmeos ver que la escala de grises no es la más adecuada, no vemos con una mayor clariadad los rectangulos de menor proporción haciendonos creer que hay menos datos, en fin podemos ver como esto deriva a dar una mala estadistica.

# Por eso graficaremso un digrama de mosaico con la función: mosaicplot()
# Pero ahora lo graficaremos con los valores de porcentajes

#Ponemos titulos, color y cambiamos la orientación de los ejes:

png(filename = "Mosaico.png")

mosaicplot(porcentaje_tabla2, main = "Eficiencia del Modelo",
           color = 2:7, las = 1)

# Con esto podemos ver de una manera más visual los resultados, dandonos mejkres estadisticas
dev.off()