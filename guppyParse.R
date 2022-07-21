library(lubridate)
library(chron)

# CSV being read in must only contain lines containing "Caller time, Samples Called and samples/s"
# i.e.: Caller time: 17069341 ms, Samples called: 1670067223019, samples/s: 9.78402e+07
guppyCsv <- read.csv2(guppy_file.out", sep=",",header = F)
guppyCsv$V1 <- gsub("Caller time:", "", guppyCsv$V1)
guppyCsv$V1 <- gsub("ms", "", guppyCsv$V1)
guppyCsv$V2 <- gsub("Samples called:", "", guppyCsv$V2)
guppyCsv$V3 <- gsub("samples/s:", "", guppyCsv$V3)
guppyCsv$V1 <- format(as.POSIXct(as.integer(guppyCsv$V1) / 1000, "UTC", origin = "1970-01-01"), "%H:%M:%OS3")
mean(times(guppyCsv$V1))
guppy_times <- seconds_to_period(mean(period_to_seconds(hms(guppyCsv$V1))))
guppy_times_sd <- sd(seconds_to_period(period_to_seconds(hms(guppyCsv$V1))))
guppy_times_sd <- seconds_to_period(guppy_times_sd)
guppy_samples <- mean(as.numeric(guppyCsv$V2))
guppy_samples_sd <- sd(as.numeric(guppyCsv$V2))
guppy_samplespersec <- mean(as.numeric(guppyCsv$V3))
guppy_samplespersec <- sd(as.numeric(guppyCsv$V3))
