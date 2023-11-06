local Translations = {
    success = {
        hunger_set = 'Fitbit: Varování o hladu nastaveno na %{hungervalue}%',
        thirst_set = 'Fitbit: Varování o žízni nastaveno na %{thirstvalue}%',
    },
    warning = {
        hunger_warning = 'Váš hlad je na %{hunger}%',
        thirst_warning = 'Vaše žízeň je na %{thirst}%'
    },
    info = {
        fitbit = 'FITBIT '
    }
}

if GetConvar('qb_locale', 'en') == 'cs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
--translate by stepan_valic