W_load <- function(dir){
    files = list.files(dir)
    nfile = length(files)
    out = matrix(list(), 1, nfile)
    dft = c("fi","dir","files","dft","out","nfile");
    for (fi in 1:nfile){
        print(sprintf('loading file %d:%s', fi, files[fi]))
        rm(list=setdiff(ls(), dft))
        load(file.path(dir,files[fi]))
        tlst = setdiff(ls(), dft)
        filei = tools::file_path_sans_ext(files[fi])
        if (length(tlst) == 1){

        }
        out[[filei]] = matrix(list(),1, length(tlst))
        for (i in 1:length(tlst)){
            out[[filei]][[tlst[i]]] = get(tlst[i])
        }
    }
    return(out)
}

W_csv <- function(dir){
    files = list.files(dir)
    nfile = length(files)
    out = matrix(list(), 1, nfile)
    dft = c("fi","dir","files","dft","out","nfile");
    for (fi in 1:nfile){
        print(sprintf('loading file %d:%s', fi, files[fi]))
        rm(list=setdiff(ls(), dft))
        te = read.csv(file.path(dir,files[fi]))
        out[[fi]] = list()
        out[[fi]]$data = te
        out[[fi]]$filename = tools::file_path_sans_ext(files[fi])
    }
    return(out)
}

