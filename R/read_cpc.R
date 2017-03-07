#' Read a CPCe data file
#'
#' @param file
#' @param encoding
#' @param fileEncoding
#'
#' @return
#' @export
#'
#' @examples
read_cpc <- function(file, encoding = "unknown", fileEncoding = "") {
	if (is.character(file)) {
		file <- if (nzchar(fileEncoding))
			file(file, "rt", encoding = fileEncoding)
		else file(file, "rt")
		on.exit(close(file))
	}
	if (!isOpen(file, "rt")) {
		open(file, "rt")
		on.exit(close(file))
	}
	file_data <- read.csv(file, header = F, nrows = 1, encoding = encoding,
												fileEncoding = fileEncoding)
	# image dimensions in the meta?
	# check that the bounding box is correc
	bounding_box <- read.csv(file, header = F, skip = 0, nrows = 4,
													 encoding = encoding, fileEncoding = fileEncoding)
	names(bounding_box) <- c("x", "y")
	row.names(bounding_box) <- c("top_left", "top_right", "bottom_right", "bottom_left")
	n_points <- scan(file, nlines = 1, skip = 0, quiet = F)
	point_coords <- read.csv(file, header = F, skip = 0, nrows = n_points,
													 encoding = encoding, fileEncoding = fileEncoding)
	sample_points <- read.csv(file, header = F, skip = 0, nrows = n_points,
														encoding = encoding, fileEncoding = fileEncoding,
														stringsAsFactors = T)
	sample_points <- sample_points[, -3]
	sample_points[, 1] <- LETTERS[sample_points[, 1]]
	names(sample_points) <- c("point", "id", "notes")
	header <- read.csv(file, header = F, skip = 0,
										 encoding = encoding, fileEncoding = fileEncoding,
										 blank.lines.skip = F)
	row.names(header) <- header_fields
	list(code_file_path = as.character(file_data[, 1]),
			 image_path = as.character(file_data[, 2]),
			 border = bounding_box,
			 n_point = n_points,
			 data_point = sample_points,
			 point_coord = point_coords,
			 header = header)
}
