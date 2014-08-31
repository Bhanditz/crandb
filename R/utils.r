
create_file_if_missing <- function(path, parent = TRUE) {

  if (parent) {
    dir <- dirname(path)
    if (!file.exists(dir)) { dir.create(dir, recursive = TRUE) }
  }

  if (!file.exists(path)) { cat("", file = path) }

  invisible(path)
}

extract_only <- function(list, names) {
  names <- intersect(names(list), names)
  list[names]
}

with_wd <- function(dir, expr) {
  wd <- getwd()
  on.exit(setwd(wd))
  setwd(dir)
  eval(expr, envir = parent.frame())
}

trim <- function (x) gsub("^\\s+|\\s+$", "", x)

trim_leading <- function (x)  sub("^\\s+", "", x)

trim_trailing <- function (x) sub("\\s+$", "", x)

check_external <- function(cmdline) {
  system(cmdline, ignore.stdout = TRUE, ignore.stderr = TRUE) %>%
    equals(0)
}

check_couchapp <- function() {
  if (!check_external("couchapp")) {
    stop("Need an installed couchapp")
  }
}

NA_NULL <- function(x) {
  if (length(x) == 1 && is.na(x)) NULL else x
}

unboxx <- function(x) {
  if (inherits(x, "scalar") ||
      is.null(x) ||
      is.list(x) ||
      length(x) != 1) x else unbox(x)
}

rsync <- function(from, to, args = "-rtlzv --delete") {
  cmd <- paste("rsync", args, from, to)
  system(cmd, ignore.stdout = TRUE, ignore.stderr = TRUE)
}

query <- function(url, ...) {
  url %>%
    GET() %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON(...)
}

add_class <- function(x, class_name) {
  if (! inherits(x, class_name)) {
    class(x) <- c(class_name, attr(x, "class"))
  }
  x
}

contains <- function(x, y) y %in% x

isin <- function(x, y) x %in% y

remove_special <- function(list, level = 1) {

  assert_that(is.count(level), level >= 1)

  if (level == 1) {
    names(list) %>%
      grepl(pattern = "^_") %>%
      replace(x = list, values = NULL)
  } else {
    lapply(list, remove_special, level = level - 1)
  }

}

pluck <- function(list, idx) list[[idx]]
