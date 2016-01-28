Dota Hero Recommender - V 1.0
========================================================
author: Zachary Vincent Smith
date: Jan 28th 2016

Purpose
========================================================

DOTA (Defence of the Ancients) is a video game currently developed by Valve in which two
teams of 5 compete against each other in an attempt to destroy the opposing sides ancient.

It is notoriously difficult for new players to learn the game, and a major contributing factor
to that are the 110 unique heroes that players may choose from. The purpose of this app is to
assist new players in choosing heroes that properly counter the opposing team.

It is quite simple to use, players simply input the 5 heroes they will be competing against, and
the app sends back its reccomendation.

DOTA's Heroes
========================================================




```r
head(hero_frame)
```

```
          hero_names
1          Alchemist
2 Ancient Apparition
3          Anti-Mage
4         Arc Warden
5                Axe
6               Bane
```

```r
str(hero_frame)
```

```
'data.frame':	110 obs. of  1 variable:
 $ hero_names: chr  "Alchemist" "Ancient Apparition" "Anti-Mage" "Arc Warden" ...
```

Under the Hood
========================================================

Reccomendation's are made based on statistics from all public DOTA matches in the previous month. Each hero on the enemy team has its counter heroes ranked
and then the app simply picks the common hero with the highest ordinal ranking to make its reccomendation.

All data comes from [Dota Buff](http://www.dotabuff.com/) a fantastic web resource for DOTA enthusiats and stat nerds alike.

Future Versions
========================================================

Due to time constraints this early version does not include the features or polish that I would like. In the future I would like to add...

- Variable Enemy Numbers
- Role Selection (Support, Carry, Jungle etc)
- Prettier Interface
- Caching to reduce load times

Questions or comments? I can be reached at zv2.2smith@gmail.com
