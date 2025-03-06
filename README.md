# Transfermarket Analysis 📊  
🚀 *Analysis of the best league to league transfers*

## Project

The primary goal of this project was to analyze league to league transfers. What is league to league transfer? For example you are a player who goes from Ajax to Barselona. It means that you goes from first devision of Netherlands domestic chempionship to first division of Spanish domestic chempionship. In our final table we will see it like `from_NL1_to_ES1` in `league_transfer` column or like `from_Netherlands_to_Spain` in `country_transfer` column. The purpose is to find best of from league to league transfers based on our metrics. The metric we will use in that project is how in average market value of player changes after 1 year of transfer. The logic is simple: if you are young player and the change of league suits you the most you will play good and that will increase your market value.

This analysis can be usefull like for manegers of clubs who are looking for new signing to point the league in wicth potential new player now playes. Or for players who want to play in big leagues like England or Spain and they look for the best tramplin 'springboard' league fir that.

![Image of last table](https://github.com/ZvorskyiB/SQL_pet_project/blob/main/Images/Final_table_first10.png)

The most challenging part of the project was to join two tables: transfers and player_valuations and to make it work fast enough. I was experimenting with different versions of sql code. I even asked my father of advice becouse he has lot of experience in Oracle SQL. The solution was to join two tables in the way very close to what `cross join` does and than I `group by` all of that. I didn't use any of `join`s in this project, instead I used `where` to join tables becouse it is how my father tought me to do that and I find it very simple and understandable . I could hane rewritten the code using `left join` or `cross join` to show tah I know this tools but first rule of programmer (if it works DON'T touch it!) didin't allow me to do that.


## Database

**Source:** [https://www.kaggle.com/datasets/davidcariboo/player-scores) (scraped or exported CSV files).  
**Format:** `.csv` files containing player transfer data.  

![]



