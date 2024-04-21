

library("readxl")
file_path <- "INSERT OWN PATH HERE"
stats <- read_excel(file_path)

str(stats)
length(stats)


# Train on all but last data row
all_but_last_row <- stats[-nrow(stats),]


# All years but 2023
yr <- stats$year[-nrow(stats)]

# Graduates - Excluding the last row (2023)
examen <- c( #yr,
            stats$foretagsforsaljningE[-nrow(stats)],
            stats$redovisningsekonomE[-nrow(stats)],
            stats$programmeringE[-nrow(stats)],
            stats$webbutvecklareE[-nrow(stats)],
            stats$HotelManagementE[-nrow(stats)],
            stats$yrkessvetsareE[-nrow(stats)],
            stats$fordonsteknikerE[-nrow(stats)],
            stats$bagarekonditorE[-nrow(stats)],
            stats$kartmatteknikerE[-nrow(stats)],
            stats$byggledareE[-nrow(stats)],
            stats$fastighetsforvaltareE[-nrow(stats)],
            stats$djurvardareE[-nrow(stats)] )

# Starting numbers - all but the last row
utbildningar <- c( #yr,
                  stats$foretagsforsaljning[-nrow(stats)],
                  stats$redovisningsekonom[-nrow(stats)],
                  stats$programmering[-nrow(stats)],
                  stats$webbutvecklare[-nrow(stats)],
                  stats$HotelManagement[-nrow(stats)],
                  stats$yrkessvetsare[-nrow(stats)],
                  stats$fordonstekniker[-nrow(stats)],
                  stats$bagarekonditor[-nrow(stats)],
                  stats$kartmattekniker[-nrow(stats)],
                  stats$byggledare[-nrow(stats)],
                  stats$fastighetsforvaltare[-nrow(stats)],
                  stats$djurvardare[-nrow(stats)] )

namn <- list(
            foretagsforsaljning = stats$foretagsforsaljning[-nrow(stats)],
            redovisningsekonom = stats$redovisningsekonom[-nrow(stats)],
            programmering = stats$programmering[-nrow(stats)],
            webbutvecklare = stats$webbutvecklare[-nrow(stats)],
            HotelManagement = stats$HotelManagement[-nrow(stats)],
            yrkessvetsare = stats$yrkessvetsare[-nrow(stats)],
            fordonstekniker = stats$fordonstekniker[-nrow(stats)],
            bagarekonditor = stats$bagarekonditor[-nrow(stats)],
            kartmattekniker = stats$kartmattekniker[-nrow(stats)],
            byggledare = stats$byggledare[-nrow(stats)],
            fastighetsforvaltare = stats$fastighetsforvaltare[-nrow(stats)],
            djurvardare = stats$djurvardare[-nrow(stats)]
          )


# Numbers to predict by - the last row
starters <- c( #tail(stats$year, n=1),
              tail(stats$foretagsforsaljning, n=1),
              tail(stats$redovisningsekonom, n=1),
              tail(stats$programmering, n=1),
              tail(stats$webbutvecklare, n=1),
              tail(stats$HotelManagement, n=1),
              tail(stats$yrkessvetsare, n=1),
              tail(stats$fordonstekniker, n=1),
              tail(stats$bagarekonditor, n=1),
              tail(stats$kartmattekniker, n=1),
              tail(stats$byggledare, n=1),
              tail(stats$fastighetsforvaltare, n=1),
              tail(stats$djurvardare, n=1) )


#===========================================
par(mfrow=c(2,2))
# Plot two programs to check its values
plot(yr, stats$djurvardare[-nrow(stats)], type = "o", col = "blue", ylim = range(stats[, c("djurvardare", "djurvardareE")], na.rm = TRUE),xlab = "Årtal", ylab = "Antal", main = "Antal påbörjade studier vs. Examen", pch = 16)
lines(yr, stats$djurvardareE[-nrow(stats)], type = "o", col = "red", pch = 16)
legend("topright", legend = c("Djurvårdare", "Examen"), col = c("blue", "red"), lty = 1, pch = 16)

plot(yr,  stats$foretagsforsaljning[-nrow(stats)], type = "o", col = "blue", ylim = range(stats[, c("foretagsforsaljning", "foretagsforsaljningE")], na.rm = TRUE), xlab = "Årtal", ylab = "Antal", main = "Antal påbörjade studier vs. Examen", pch = 16)
lines(yr, stats$foretagsforsaljningE[-nrow(stats)], type = "o", col = "red", pch = 16)
legend("topright", legend = c("Företagsförsäljning", "Examen"), col = c("blue", "red"), lty = 1, pch = 16)

#===========================================

plots_values <- c()
plotp_values <- c()

# Loop through the different programs in the data table
for (i in seq_along(starters)) {
  
  model <- glm(examen[[i]] ~ utbildningar[[i]], data = all_but_last_row,family = poisson) #
  
  df <- data.frame(starters[[i]])
  predicted_values <- predict(model, newdata = df, type = "response") #
  
  # for the plots
  plots_values <- c(plots_values, starters[[i]])
  plotp_values <- c(plotp_values, predicted_values)
  

  # Calculate MAE
  mae <- mean(abs(predicted_values - starters[[i]]))

  cat(sprintf("Program: %s: \n Påbörjade studier : %s, Uppskattade examensantal: %s, MAE: %s \n \n", names(namn)[i],
              starters[[i]], predicted_values, mae ))
}

par(mfrow=c(1,1))
# Plot the actual vs. predicted values
plot(plots_values, plotp_values, xlab = "Påbörjade studier ", ylab = "Uppskattade examensantal", main = "Påbörjade antal studier vs. Uppskattade examensantal", pch = 16, col = "blue")
abline(0, 1, col = "red", lty = 2)


#==========================================









