# Required Libraries
library(rvest)

adjust_names <- function(name){
    # Function takes hero names as a string and modifies them for proper URL formatting
    return(tolower(gsub("'","",(gsub(" ","-",name)))))
}

build_url <- function(adj_name, hero_page = FALSE){
    # Function takes an adjusted name and builds a URL depending on the destination specified by the boolean.
    if (hero_page) {
        link = paste("http://www.dotabuff.com/heroes/",adj_name, sep = "")
        return(link)
    }
    else {
        link = paste("http://www.dotabuff.com/heroes/",adj_name,"/matchups", sep = "")
        return(link)
    }
}

role_frame <- function(roles){
    # Function builds a list of boolean values corresponding to a string containing roles.
    dota_roles <- c("Melee","Ranged","Carry","Disabler","Initiator","Jungler","Support","Durable","Nuker","Pusher","Escape")
    role_check <- c(F,F,F,F,F,F,F,F,F,F,F)
    count = 1
    for (i in dota_roles){
        role_check[count] = grepl(i,roles)
        count = count + 1
    }
    return(role_check)
}

get_roles <- function(adj_name){
    # Function takes an adjusted hero name and returns a list of that hero's roles.
    role_list <- data.frame(F,F,F,F,F,F,F,F,F,F,F,F)
    for (i in adj_name) {
        url <- build_url(i, hero_page = TRUE)
        role_string <- url %>% read_html() %>% html_nodes(xpath='/html/body/div[1]/div[7]/div[2]/div[1]/div[1]/div[2]/h1/small') %>% html_text()
        role_list <- rbind(role_list,role_frame(role_string))
    }
    role_list = role_list[-1,]
    colnames(role_list) <- c("Melee","Ranged","Carry","Disabler","Initiator","Jungler","Support","Durable","Nuker","Pusher","Escape")
    return(role_list)
}

load_fun <- function(){
    # Function initialises the hero_frame
    ref_url <- "http://www.dotabuff.com/heroes/abaddon/matchups"
    hero_names <- sort((ref_url %>% read_html() %>% html_nodes(xpath='/html/body/div[1]/div[7]/div[3]/section/article/table') %>% html_table())[[1]][,2])
    adj_names <- adjust_names(hero_names)
    roles <- get_roles(adj_names)
    hero_frame <- data.frame(hero_names,adj_names,roles)
    return(hero_frame)
}

`%notin%` <- function(x,y) !(x %in% y) 

recommended_hero <- function(opposition_list){
    # Function takes a list of opposing heroes and returns the best counter to all 5.
    Ranking <- 0:109
    Score <- list(rep(0, 110))
    Heroes <- hero_frame$hero_names
    score_frame <- data.frame(Heroes,Score)
    colnames(score_frame)[2] <- "Score"
    adj_list = adjust_names(opposition_list)
    for (hero in adj_list){
        raw_ranking <- build_url(hero) %>% read_html() %>% html_nodes(xpath='/html/body/div[1]/div[7]/div[3]/section/article/table') %>% html_table()
        ranking_list <- rev(raw_ranking[[1]][,2])
        scored_list <- data.frame(ranking_list,Ranking)
        scored_list <- scored_list[order(scored_list[,1]),]
        score_frame[,2] <- score_frame[,2] + scored_list[,2]
    }
    
    score_frame <- score_frame[which(score_frame$Heroes %notin% opposition_list),]
    score_frame <- score_frame[order(score_frame[,2]),]
    return(score_frame[1:5,1])
}

# Initialise App Data
hero_frame = load_fun()
hero_frame$hero_names = as.character(hero_frame$hero_names)
hero_frame$adj_names = as.character(hero_frame$adj_names)