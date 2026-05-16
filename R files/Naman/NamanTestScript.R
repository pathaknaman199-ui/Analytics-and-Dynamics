load_rdat <- function(filepath) {
  if (!file.exists(filepath)) {
    stop("File not found: ", filepath)
  }
  
  before <- ls(envir = .GlobalEnv)
  load(filepath, envir = .GlobalEnv)
  after <- ls(envir = .GlobalEnv)
  
  new_objects <- setdiff(after, before)
  
  cat("Loaded", length(new_objects), "object(s):\n")
  for (name in new_objects) {
    obj <- get(name)
    cat(" -", name, ":", class(obj), "\n")
  }
  
  invisible(new_objects)
}

# Load WITHOUT assigning — objects go directly into your environment
load_rdat("C:/Users/patha/Desktop/Programs/ISM/Semester 3/Analytics and Dynamics/Analytics and Dynamics/R files/traffic.Rdat")

# Now check what was loaded
ls()

# Then use whatever name the file contained (e.g. "traffic")
str(out)
summary(out)
head(out)
tail(out)
View(out)


row_sums <- rowSums(out[, -1])
top_categories <- order(row_sums, decreasing = TRUE)

# See the top 10 most visited categories
out[top_categories[1:10], 1]



# Take the #1 most visited category
best_row <- top_categories[1]
cat("Analysing category:", as.character(out[best_row, 1]), "\n")

one_category <- as.numeric(out[best_row, -1])

# Convert to time series
ts_data <- ts(one_category, start = c(2005, 7), frequency = 12)
ts_data


plot(ts_data, 
     main = paste("Traffic:", as.character(out[best_row, 1])),
     ylab = "Monthly Visits",
     xlab = "Year",
     col = "blue")

