local Translations = {
    success = {
        hunger_set = 'Fitbit: Hungerwarnung auf %{hungervalue}% gesetzt',
        thirst_set = 'Fitbit: Durstwarnung auf %{thirstvalue}% gesetzt',
    },
    warning = {
        hunger_warning = 'Dein Hunger liegt bei %{hunger}%',
        thirst_warning = 'Dein Durst liegt bei %{thirst}%',
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