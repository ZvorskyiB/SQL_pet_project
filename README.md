# Transfermarket Analysis 📊  
🚀 *Analysis of the best league to league transfers*

## Project

The primary goal of this project was to analyze league to league transfers. What is league to league transfer? For example you are a player who goes from Ajax to Barselona. It means that you go from first division of Netherlands domestic championship to first division of Spanish domestic chempionship. In our final table we will see it like `from_NL1_to_ES1` in `league_transfer` column or like `from_Netherlands_to_Spain` in `country_transfer` column. The purpose is to find best of from league to league transfers based on our metrics. The metric we will use in that project is how on average market value of player changes after 1 year of transfer. The logic is simple: if you are young player and the change of league suits you the most you will play good and that will increase your market value.

This analysis can be useful like for managers of clubs who are looking for new signing to point the league in which potential new player now plays. Or for players who want to play in big leagues like England or Spain and they look for the best 'springboard' league for that.

![Image of last table](https://github.com/ZvorskyiB/SQL_pet_project/blob/main/Images/Final_table_first10.png)

The most challenging part of the project was to join two tables: `transfers` and `player_valuations` and to make it work fast enough. I was experimenting with different versions of sql code. I even asked my father for advice because he has a lot of experience in Oracle SQL. The solution was to join two tables in the way very close to what `cross join` does and than I `group by` all of that. I didn't use any of `join`s in this project, instead I used `where` to join tables becouse it is how my father taught me to do that and I find it very simple and understandable . I could have rewritten the code using `left join` or `cross join` to show that I know this tools but first rule of programmer (if it works DON'T touch it!) didn't allow me to do that.


## Worth attention

* At the date of transfer player must be less than 27 years old. That is because we use market value difference after 1 year of transfer as how good player does in new club. But for old players even if you play well your market value will decrease becouse of your age.
* We work on a period between 2019 and 2024. This is because of inflation of transfer market value of player every year. Big history transfers like Pogba to Manchester United or Neymar to PSG changed market of transfers. Players started to cost more and without of starting playing better. We can't compare market values of legend of the past Zidane with average good players like James, when James had bigger maximum market value than maximum market value then Zidane. That is why we look only on the data for last 5 years.  
* The date when we check your transfer value after 1 year of transfer can't be more then 1.3 year after transfer. We have market values of every player in spetial table called `players_valuations`. In this table we have 3 main columns: the id of player, date when we check his market value and his market value in that date. Life would be perfect for us if we had market value of player checked every day. But it also would be exhausting for guys from tranfermarket.com who mesure it and put to our table. So the gap between date of transfer and date when we have his market value mesured can be more than 1 year. And for us it is important that this gap is less then 1.3 year.
* The number of league to league transfers must be more or equal then 7 in our final table. If we do not do it we will have that the best is league to league transfer is from Turkey to Spain. But for the last 5 years we had only one transfer like that and it is Arda Guler to Real Madrid. It is outlier and it doesn't show us the real trends it the market of transfers. In order to eliminate as many outliers as possible we write that the number of league to league transfers must be more or equal then 7.


## Database

**Source:** [https://www.kaggle.com/datasets/davidcariboo/player-scores) (scraped or exported CSV files).  
**Format:** `.csv` files containing player transfer data.  

![Scheme](https://github.com/ZvorskyiB/SQL_pet_project/blob/main/Images/scheme.png)  

Meaning of each csv file:

* `club_games.csv` -- Table with the record of every game between clubs. We don't use that table in our project but it was in original database we downloaded from Kaggle
* `clubs.csv` -- Table with information of every club such as: what is domestic competition of this club, the name of the club and other attributes. We use that table to know from what club and to which club our player went 
* `competitions.csv` -- Table with information of every competiton like the country of competition, full name of competiton and other attributes. We use this table to know from what league to what league our player went
* `games.csv` -- Table with information of every game like who played, how many goals were scored by each side and other attributes. We don't use that table in ouer project but it was in original database we downloaded from Kaggle
* `player_valuations.csv` -- We mentioned this table before, it keeps id of player, his market value, date when this value was measured and other attributes
*  `players.csv` -- Table with information of every player such as name, date of birth and other attributes. We don't use this table in our project but it was in original database we downloaded from Kaggle
*  `transfers.csv` -- Table with information of every transfer like id of player, id of the club he left, id of the club he joined, the date of transfer, price that was paid for him, his market value of that moment and other attributes. It is very important table in our project.


## Next steps
* Use other metrics. Like 2 years after transfer or 3 years after transfer. Not all of the players show their best perfomance in their first year at the club. We have example of Raphinha who plays at a world class level only in his 3rd year in Barcelona. Someones need more time for adaptation.  

  Or we can use average minutes player has played in every competition as a metric. For some managers it doesn't matter if your market value is decreasing, they need players to play and often. This metric has a plus that now we can involve old players to that analysis. But also it doesn't really show how good you are. We can have a pair of centre defenders and they will play almost in every match almost 90 minutes, because they play for small club which can't afford good substitutes. But one of defenders can play better then another and we will not see the difference. Also, that a problem between players in big clubs and small clubs. You can be very good player like Brahim Diaz in Real Madrid but you have very big competition for the place in strating 11 in your club. That is why this metric will be low for players like him when we can have some average player in his position in small club who plays more minutes because he plays in small club.  

* Or we can make up a formula to create new metric which will consider market value inflation through years 
* Find a better database. This database doesn't cover most leagues. We don't have Brazil or Argentina here, but they are very important leagues for market of transfers 







