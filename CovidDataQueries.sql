
-- Covid Deaths Data:
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject.dbo.CovidDeaths
order by 1,2

-- Total Cases vs Total Deaths over Time
Select Location, date, Total_cases, Total_deaths, population, (total_deaths/total_cases)*100 as MortalityRate
From PortfolioProject.dbo.CovidDeaths
-- Where location like '%Brazil%'
order by 1,2

-- Total Cases vs Population over Time
Select Location, date, total_cases, population, (total_cases/population)*100 as InfectionRate
From PortfolioProject.dbo.CovidDeaths
-- Where location like '%Brazil%'
order by 1,2

--Countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectionRate
From PortfolioProject.dbo.CovidDeaths
--Where location like '%Brazil%'
Group by Location, population 
Order by InfectionRate desc

--Countries with Highest Infection Rate compared to Population
Select Location, Population, sum(new_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths, (sum(new_cases)/population)*100 as InfectionRate, sum(cast(new_deaths as int))/(sum(new_cases))*100 as MortalityRate, sum(cast(new_deaths as int))/(population)*100 as DeathPercentageOfPopulation
From PortfolioProject.dbo.CovidDeaths
--Where location like '%Brazil%'
Where continent is not null
Group by Location, population
Order by TotalDeaths desc

-- Highest Mortality Rate
Select Location, population, MAX(cast(total_deaths as int)) as HighestDeathCount, MAX((total_deaths/population)) * 100 as PercentageOfPopulationDead
From PortfolioProject.dbo.CovidDeaths
--Where location like '%Brazil%'
Where continent is not null
Group by Location, population
Order by PercentageOfPopulationDead desc

-- Global Numbers
Select SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as MortalityRate
From PortfolioProject.dbo.CovidDeaths
Where continent is not null
order by 1,2

-- Total Population vs Vaccinations (percentage of country vaccinated)
Select dea.location, dea.population, Max(cast(vac.total_vaccinations as int)) as TotalDoses, (Max(cast(vac.total_vaccinations as int)))/2/dea.population*100 as PercentVaccinated
From PortfolioProject.dbo.CovidDeaths dea
Join PortfolioProject.dbo.CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null and dea.population is not null
Group by dea.Location, dea.Population
Order by PercentVaccinated desc


--Creating View

Create View BasicCovidInfo as
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject.dbo.CovidDeaths

Create View Cases as
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectionRate
From PortfolioProject.dbo.CovidDeaths
Where continent is not null
--Where location like '%Brazil%'
Group by Location, population 





