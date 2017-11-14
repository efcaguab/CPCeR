#' Read a CPC code file
#'
#' @param file
#' @param encoding
#' @param fileEncoding
#'
#' @return a list with two data frames describing the major and the minor categories
#' @export
#'
#' @examples
read_codefile <- function(file, encoding = "unknown", fileEncoding = "") {
        #open and read file
        con<-file(filename)#("C:/CPCe_41_inst/code/Aldabra code file svwr130523.txt") #
        open(con)
        num.maj.categ <- as.integer(read.csv(con,header = FALSE, sep = ", ", skip=2,nrow=1)) #3-th line - this is how many lines constitute major categories
        maj.category <- read.csv(con,header = FALSE, sep = ", ", skip=0,nrow = num.maj.categ)
        tmp <- read.csv(con, header = FALSE, sep = ", ", skip = 0)
        close(con)
        notes.line <- which(tmp$V3 == "NOTES")
        min.category <- tmp[1:(notes.line-1), 1:3]
        rm(tmp)
        
        # object to be returned
        list(major_categ = data.frame(major_code = maj.category$V1,
                                      major_name = maj.category$V2,
                                      col = maj.category$V3),
             minor_categ = data.frame(minor_code = min.category$V1,
                                      minor_name = min.category$V2,
                                      major_code = min.category$V3),
             notes_categ = data.frame(note_code = NULL,
                                      note_name = NULL,
                                      major_code = NULL))
        #insert major code data
        # obtain the value for how many lines of text consitute major categories without reading in the file



        
}
