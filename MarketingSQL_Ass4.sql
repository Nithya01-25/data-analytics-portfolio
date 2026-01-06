SELECT 
    c.Campaign_ID,              -- 1. Core info
    c.Target_Audience,          -- 1. Core info
    c.Campaign_Goal,            -- 1. Core info
    SUM(cp.Impressions) AS total_impressions, -- 3. SUM by ID
    SUM(cp.Clicks) AS total_clicks,           -- 3. SUM by ID
    -- 4. Compute CTR with decimal casting and division-by-zero protection
    SUM(cp.Clicks)::decimal / NULLIF(SUM(cp.Impressions), 0) AS computed_ctr,
    -- 5. Show costs and conversions (calculated from conversion rate)
    SUM(c.Acquisition_Cost) AS total_acquisition_cost,
    SUM(cp.Clicks * c.Conversion_Rate) AS total_estimated_conversions
FROM 
    campaign1 c                 -- Core campaign table
JOIN 
    campaignoverview cp         -- Performance table
    ON c.Campaign_ID = cp.Campaign_ID -- 5. JOIN on ID
WHERE 
    cp.Impressions > 1000    -- 2. Filter performance
    AND cp.Clicks > 1000     -- 2. Filter performance
GROUP BY 
    c.Campaign_ID, 
    c.Target_Audience, 
    c.Campaign_Goal;           -- 5. Grouped by campaign info