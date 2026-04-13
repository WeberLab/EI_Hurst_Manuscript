# Timing Analysis Script
# Loads Timing.csv and computes average durations between Rest and Movie conditions

library(dplyr)

# --- Load data ---
timingdf <- read.csv("Timing.csv", stringsAsFactors = FALSE)

# Trim whitespace from column names (in case of leading spaces)
names(timingdf) <- trimws(names(timingdf))

# --- Helper: parse HHMMSS integer to seconds since midnight ---
hhmmss_to_seconds <- function(x) {
  x <- as.integer(x)
  hh <- x %/% 10000
  mm <- (x %% 10000) %/% 100
  ss <- x %% 100
  hh * 3600 + mm * 60 + ss
}

# --- Convert all timing columns ---
timingdf <- timingdf %>%
  mutate(
    RestLaser_s  = hhmmss_to_seconds(RestLaser),
    RestMega_s   = hhmmss_to_seconds(RestMega),
    MovieLaser_s = hhmmss_to_seconds(MovieLaser),
    MovieMega_s  = hhmmss_to_seconds(MovieMega)
  )

# --- Compute per-subject differences (in seconds) ---
timingdf <- timingdf %>%
  mutate(
    Diff_Laser = abs(MovieLaser_s - RestLaser_s),
    Diff_Mega  = abs(MovieMega_s  - RestMega_s),
    Diff_Rest = abs(RestMega_s - RestLaser_s),
    Diff_Movie = abs(MovieMega_s - MovieLaser_s),
  )

# --- Print per-subject table ---
cat("=== Per-Subject Time Differences ===\n")
print(timingdf %>% select(Subject, Diff_Laser, Diff_Mega, Diff_Rest, Diff_Movie))

# --- Compute and print averages ---
avg_laser <- mean(timingdf$Diff_Laser)
avg_mega  <- mean(timingdf$Diff_Mega)
sd_laser <- sd(timingdf$Diff_Laser)
sd_mega  <- sd(timingdf$Diff_Mega)
avg_rest <- mean(timingdf$Diff_Rest)
avg_movie  <- mean(timingdf$Diff_Movie)
sd_rest <- sd(timingdf$Diff_Rest)
sd_movie  <- sd(timingdf$Diff_Movie)

cat("\n=== average durations ===\n")
cat(sprintf("average +/- sd time from restlaser  to movielaser : %.1f +/- %.1f seconds (%.2f +/- %.2f minutes)\n",
            avg_laser, sd_laser, avg_laser / 60, sd_laser / 60))
cat(sprintf("average +/- sd time from restmega   to moviemega  : %.1f +/- %.1f seconds (%.2f +/- %.2f minutes)\n",
            avg_mega, sd_mega,  avg_mega  / 60, sd_mega / 60))

cat(sprintf("average +/- sd time from restlaser  to restmega : %.1f +/- %.1f seconds (%.2f +/- %.2f minutes)\n",
            avg_rest, sd_rest, avg_rest / 60, sd_rest / 60))
cat(sprintf("average +/- sd time from movielaser   to MovieMega  : %.1f +/- %.1f seconds (%.2f +/- %.2f minutes)\n",
            avg_movie, sd_movie,  avg_movie  / 60, sd_movie / 60))
