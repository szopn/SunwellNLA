Addon wykorzystuje komende ".listninja" udostepniona przez administracje serwera Sunwell. Po dolaczeniu lub aktualizacji grupy zostaja sprawdzeni wszyscy czlonkowie naszego party. Jesli w naszej grupie znajduje sie osoba bedaca na liscie "ninja looterow", wtedy zostaje wyswietlone ostrzeżenie z nickiem tej osoby wraz z komunikatem dzwiekowy.

W pliku z addonem (NLA.lua) jest mozliwosc zmiany domyslnych ustawien. W tym celu nalezy edytowac ten fragment kodu:
```
-- CONFIG --
addonnotification=true
addonemote=false
soundalert=true 
devmode=true
testnickname="Cap" -- example nickname from .listninja
-- CONFIG --
```

```addonnotification``` - Odpowiada za wlaczenie powiadomienia wyswietlajacego sie tylko dla nas

```addonemote``` - Informuje inne osoby o "ninja looterze" znajdujacym sie w naszej grupie (za pomoca komendy /e <wiadomosc>)

```soundalert``` - Powiadomienie dzwiekowe, zalezne od naszych ustawien glosnosci

Przy uzyciu komeny ```/nla help```  mozemy sprawdzic krotki opis dzialania addonu

```/nla``` - Pokazuje sunwellowa liste (.listninja) wraz z ostrzeżeniem jesli w naszej grupie znajduje sie osoba z tej listy

```/nla reset``` - Usuwa z pamieciu nicki osob pojawionych sie w ostrzeżeniach ( w tej grupie )
