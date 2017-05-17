Addon wykorzystuje komende ".listninja" udostepniona przez administracje serwera Sunwell.pl. Po dolaczeniu do grupy lub jej aktualizacji zostaja sprawdzeni wszyscy czlonkowie tej grupy. Jesli w naszej grupie znajduje sie osoba bedaca na liscie "ninja looterow", wtedy zostaje wyswietlone ostrzeżenie z nick tej osoby oraz odtworzony dzwiek. Pomijajac sam komunikat, ktory wyswietla sie tylko dla nas, zostaje tez uzyte polecenie "/e msg" informujace czlonkow naszej grupy o osobie bedace na serwerowej liscie.

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
