## Reddit Comments Mood Variation - Changelog

- The following libraries were installed for the purpose of data cleaning and analysis :
    - lubridate
    - syuzhet
    - tidyverse
    - tidytext
- Variables were created for the purpose of storing the data from the .csv files.
- Alpha Numeric and Foreign characters were removed.
- All comments were turned into lowercase
- The created column was in character datatype. It was converted to time datatype.
- A month and year column was created.
- The month column was ordered in actual month format. Earlier it was ordered alphabetically.
- Sentiment variables were created to store the sentiment data of each year.
- Only negative and positive sentiment data was selected for the purpose of this analysis.
- The comments data and the sentiment data was merged.
- The new comments data for each year was grouped by month and year and summarized by sum mean of negativity and positivity.
- The resultant data for each year was combined into a final dataset.