### R code from vignette source 'measurement_units_in_R.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: measurement_units_in_R.Rnw:76-84
###################################################
temp_data = subset(read.table("647_Global_Temperature_Data_File.txt", 
	header=TRUE)[1:2], Year >= 1960)
temp_data$date = as.Date(paste0(temp_data$Year, "-01-01"))
temp_data$time = as.POSIXct(temp_data$date)
Sys.setenv(TZ="UTC")
head(temp_data, 3)
year_duration = diff(temp_data$date)
mean(year_duration)


###################################################
### code chunk number 2: measurement_units_in_R.Rnw:89-90
###################################################
year_duration %*% rep(1, length(year_duration)) / length(year_duration)


###################################################
### code chunk number 3: measurement_units_in_R.Rnw:93-95
###################################################
coef(lm(Annual_Mean ~ date, temp_data))
coef(lm(Annual_Mean ~ time, temp_data))


###################################################
### code chunk number 4: measurement_units_in_R.Rnw:162-166
###################################################
library(measurements)
conv_unit(2.54, "cm", "inch")
conv_unit(c("101 44.32","3 19.453"), "deg_dec_min", "deg_min_sec")
conv_unit(10, "cm_per_sec", "km_per_day")


###################################################
### code chunk number 5: measurement_units_in_R.Rnw:173-175
###################################################
names(conv_unit_options)
conv_unit_options$volume


###################################################
### code chunk number 6: measurement_units_in_R.Rnw:179-180
###################################################
conv_dim(x = 100, x_unit = "m", trans = 3, trans_unit = "ft_per_sec", y_unit = "min")


###################################################
### code chunk number 7: measurement_units_in_R.Rnw:193-195
###################################################
library(NISTunits)
NISTwattPerSqrMeterTOwattPerSqrInch(1:5)


###################################################
### code chunk number 8: measurement_units_in_R.Rnw:213-215
###################################################
library(udunits2)
ls(2)


###################################################
### code chunk number 9: measurement_units_in_R.Rnw:219-221
###################################################
ud.is.parseable("m/s")
ud.is.parseable("q")


###################################################
### code chunk number 10: measurement_units_in_R.Rnw:224-226
###################################################
ud.are.convertible("m/s", "km/h")
ud.are.convertible("m/s", "s")


###################################################
### code chunk number 11: measurement_units_in_R.Rnw:229-230
###################################################
ud.convert(1:3, "m/s", "km/h")


###################################################
### code chunk number 12: measurement_units_in_R.Rnw:234-237
###################################################
ud.get.name("kg")
ud.get.symbol("kilogram")
ud.set.encoding("utf8")


###################################################
### code chunk number 13: measurement_units_in_R.Rnw:244-249
###################################################
m100_a = paste(rep("m", 100), collapse = "*")
m100_b = "dm^100"
ud.is.parseable(m100_a)
ud.is.parseable(m100_b)
ud.are.convertible(m100_a, m100_b)


###################################################
### code chunk number 14: measurement_units_in_R.Rnw:280-283
###################################################
library(units)
m = make_unit("m")
str(m)


###################################################
### code chunk number 15: measurement_units_in_R.Rnw:287-288
###################################################
x1 = 1:5 * m


###################################################
### code chunk number 16: measurement_units_in_R.Rnw:294-298
###################################################
x2 = 1:5 * ud_units$m
identical(x1, x2)
x3 = 1:5 * with(ud_units, m)
identical(x1, x3)


###################################################
### code chunk number 17: measurement_units_in_R.Rnw:305-306
###################################################
with(ud_units, m/s^2)


###################################################
### code chunk number 18: measurement_units_in_R.Rnw:310-315
###################################################
m =  with(ud_units,  m)
km = with(ud_units, km)
cm = with(ud_units, cm)
s =  with(ud_units,  s)
h =  with(ud_units,  h)


###################################################
### code chunk number 19: measurement_units_in_R.Rnw:319-321
###################################################
x = 1:3 * m/s
x + 2 * x


###################################################
### code chunk number 20: measurement_units_in_R.Rnw:324-327
###################################################
units(x) = cm/s
x
as.numeric(x)


###################################################
### code chunk number 21: measurement_units_in_R.Rnw:335-340
###################################################
y = 1:3 * km/h
x + y
y + x
x < y
c(y, x)


###################################################
### code chunk number 22: measurement_units_in_R.Rnw:344-346
###################################################
x * y
x^3


###################################################
### code chunk number 23: measurement_units_in_R.Rnw:349-351
###################################################
e = try(z <- x + x * y)
attr(e, "condition")[[1]]


###################################################
### code chunk number 24: measurement_units_in_R.Rnw:354-355
###################################################
methods(class = "units")


###################################################
### code chunk number 25: measurement_units_in_R.Rnw:371-375
###################################################
a = 1:10 * m/s
b = 1:10 * h
a * b
make_unit(m100_a) / make_unit(m100_b)


###################################################
### code chunk number 26: measurement_units_in_R.Rnw:379-380
###################################################
m^5/s^4


###################################################
### code chunk number 27: measurement_units_in_R.Rnw:384-390
###################################################
x = make_unit("m2 s-1")
y = km^2/h
z = m^2/s
x + y
x/y
z/y


###################################################
### code chunk number 28: measurement_units_in_R.Rnw:393-395
###################################################
parse_unit("m2 s-1")
as_cf(m^2*s^-1)


###################################################
### code chunk number 29: measurement_units_in_R.Rnw:402-415 (eval = FALSE)
###################################################
## pdf("fig1.pdf", width = 4, height = 4)
## library(units)
## units_options(negative_power = TRUE)
## gallon = make_unit("gallon")
## mtcars$consumption = mtcars$mpg * with(ud_units, mi/gallon)
## mtcars$displacement = mtcars$disp * ud_units[["in"]]^3
## units(mtcars$displacement) = with(ud_units, cm^3)
## units(mtcars$consumption) = with(ud_units, km/l)
## par(mar = par("mar") + c(0, .3, 0, 0))
## with(mtcars, plot(1/displacement, 1/consumption))
## pdf("fig2.pdf", width = 4, height = 4)
## library(ggforce)
## ggplot(mtcars) + geom_point(aes(1/displacement, 1/consumption))


###################################################
### code chunk number 30: <
###################################################
(dt = diff(Sys.time() + c(0, 1, 1+60, 1+60+3600))) # class difftime
(dt.u = as.units(dt))
identical(as.dt(dt.u), dt) # as.difftime is not a generic


###################################################
### code chunk number 31: measurement_units_in_R.Rnw:522-524
###################################################
#temperature = temp_data$Annual_Mean * with(ud_units, `°C`)
#hist(temperature, main = "temperature")


