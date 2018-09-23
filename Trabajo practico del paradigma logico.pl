% PRIMERA ENTREGA

quienMiraQue(juan,himym).
quienMiraQue(juan,futurama).
quienMiraQue(juan,got).
quienMiraQue(nico,starWars).
quienMiraQue(maiu,starWars).
quienMiraQue(maiu,onePiece).
quienMiraQue(maiu,got).
quienMiraQue(nico,got).
quienMiraQue(gaston,hoc).
quienMiraQue(pedro,got).

quiereVer(juan,hoc).
quiereVer(aye,got).
quiereVer(gaston,himym).

cantidadDeCapitulos(got,3,12).
cantidadDeCapitulos(got,2,10).
cantidadDeCapitulos(himym,1,23).
cantidadDeCapitulos(drHouse,8,16).

%Todo lo relacionado con Mad Med, o lo que Alf no mira series, no corresponde colocarlo en la base de conocimientos por el principio de universo cerrado.

paso(futurama, 2, 3, muerte(seymourDiera)).
paso(starWars, 10, 9, muerte(emperor)).
paso(starWars, 1, 2, relacion(parentesco, anakin, rey)).
paso(starWars, 3, 2, relacion(parentesco, vader, luke)).
paso(himym, 1, 1, relacion(amorosa, ted, robin)).
paso(himym, 4, 3, relacion(amorosa, swarley, robin)).
paso(got, 4, 5, relacion(amistad, tyrion, dragon)).
paso(got, 3, 2, plotTwist([suenio, sinPiernas])).
paso(got, 3, 12, plotTwist([fuego, boda])).
paso(superCampeones, 9, 9, plotTwist([suenio, coma, sinPiernas])).
paso(drHouse, 8, 7, plotTwist([coma, pastillas])).

leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, juan, futurama, muerte(seymourDiera)).
leDijo(pedro, aye, got, relacion(amistad, tyrion, dragon)).
leDijo(pedro, nico, got, relacion(parentesco, tyrion, dragon)).

esSpoiler(Serie,PosibleSpoiler):-
     paso(Serie,_,_,PosibleSpoiler).

% Se pueden realizar consultas existenciales e individuales ya que se trata de un predicado inversible

leSpoileo(PersonaUno,PersonaDos,Serie):-
    miraOQuiereMirar(PersonaDos,Serie),
    leDijo(PersonaUno,PersonaDos,Serie,Spolier),
   	esSpoiler(Serie,Spolier).

miraOQuiereMirar(Persona,Serie):-
    quienMiraQue(Persona,Serie).
miraOQuiereMirar(Persona,Serie):-
    quiereVer(Persona,Serie).

% Se pueden hacer consultas individuales y al mismo tiempo existenciales porque se trata de un predicado inversible

esPersona(Persona):-
    miraOQuiereMirar(Persona,_).
esPersona(Persona):-
  leDijo(Persona,_,_,_).

televidenteResponsable(Persona):-
    esPersona(Persona),
    not(leSpoileo(Persona,_,_)).

vieneZafando(Serie,Persona):-
	  miraOQuiereMirar(Persona,Serie),
    not(leSpoileo(_,Persona,Serie)),
    esPopularOEsFuerte(Serie).

esSerie(Serie):-
    miraOQuiereMirar(_,Serie).
esSerie(Serie):-
    cantidadDeCapitulos(Serie,_,_).

/*popular(got).
popular(hoc).
popular(starWars).
-Ya no es necesario en la segunda entrega
*/

popular(Serie):-
  esSerie(Serie),
  puntajeDePopularidad(Serie,PopularidadDeSerie),
  puntajeDePopularidad(starWars,PopularidadDeStarWars),
  PopularidadDeSerie >= PopularidadDeStarWars.

popular(hoc).

puntajeDePopularidad(Serie,Popularidad):-
  cantidadDePersonasQueMiran(CuantosMiran,Serie),
  cantidadDePersonasQueHablaron(CuantosHablan,Serie),
  Popularidad is CuantosMiran * CuantosHablan.

cantidadDePersonasQueHablaron(Cantidad,Serie):-
    esSerie(Serie),
    findall(Persona,leDijo(Persona,_,Serie,_),Personas),
    length(Personas,Cantidad).

cantidadDePersonasQueMiran(Cantidad,Serie):-
    esSerie(Serie),
    findall(Persona,quienMiraQue(Persona,Serie),Personas),
    length(Personas,Cantidad).

/*
esPopularOEsFuerte(Serie):-
    cantidadDeCapitulos(Serie,Temporada,_),
     forall(cantidadDeCapitulos(Serie,Temporada,_),fuerte(Serie,Temporada)).
*/
esPopularOEsFuerte(Serie):-
  popular(Serie).

esPopularOEsFuerte(Serie):-
    cantidadDeCapitulos(Serie,Temporada,_),
     not((cantidadDeCapitulos(Serie,Temporada,_),not(fuerte(Serie,Temporada)))).


fuerte(Serie,Temporada):-
  paso(Serie,Temporada,_,Suceso),
  sucesoFuerte(Suceso).

esFuerte(Serie,Suceso):-
  paso(Serie,_,_,Suceso),
  sucesoFuerte(Suceso).


sucesoFuerte(relacion(amorosa,Personaje1,Personaje2)):-
  suceso(relacion(amorosa,Personaje1,Personaje2)).
sucesoFuerte(relacion(parentesco,Personaje1,Personaje2)):-
  suceso(relacion(parentesco,Personaje1,Personaje2)).
sucesoFuerte(muerte(Personaje)):-
  suceso(muerte(Personaje)).
sucesoFuerte(plotTwist(PlotTwist)):-
  paso(Serie, Temporada, Capitulo,plotTwist(PlotTwist)),
  cantidadDeCapitulos(Serie, Temporada, Capitulo), %Es final de temporada
  not(esCliche(PlotTwist)).


suceso(Suceso):-
    paso(_,_,_,Suceso).



/*
esCliche(PlotTwist):-
   paso(Serie,_,_,plotTwist(PlotTwist)),
   forall(member(Palabra, PlotTwist), apareceEnOtraSerie(Palabra, Serie)).
*/

esCliche(PlotTwist):-
 paso(Serie,_,_,plotTwist(PlotTwist)),
 forall((member(Palabra, PlotTwist)),(paso(OtraSerie,_,_,plotTwist(OtraListaDePalabras)),
                                     Serie \= OtraSerie,
                                     member(Palabra, OtraListaDePalabras))).


% Falta final temporada

:- begin_tests(spoiler_alert).

test(esSpoiler_muerte_emperor_starWars, nondet) :-
	esSpoiler(starWars, muerte(emperor)).
test(esSpoiler_muerte_pedro_starWars, fail) :-
	esSpoiler(starWars, muerte(pedro)).
test(esSpoiler_relacion_anakin_rey_starWars, nondet) :-
	esSpoiler(starWars, relacion(parentesco, anakin, rey)).
test(esSpoiler_relacion_anakin_lavezzi_starWars, fail) :-
	esSpoiler(starWars, relacion(parentesco, anakin, lavezzi)).

test(leSpoileo_gaston_maiu_got, nondet) :-
	leSpoileo(gaston, maiu, got).
test(leSpoileo_nico_maiu_starWars, nondet) :-
	leSpoileo(gaston, maiu, got).

test(televidenteResponsable_juan, nondet) :-
	televidenteResponsable(juan),
	televidenteResponsable(aye),
	televidenteResponsable(maiu).

test(televidenteResponsable_nico, fail) :-
	televidenteResponsable(nico).
test(televidenteResponsable_gaston, fail) :-
	televidenteResponsable(gaston).

test(televidenteResponsable_inversible,set(UnaPersona==[juan,aye,maiu])):-
  televidenteResponsable(UnaPersona).
test(vieneZafando_maiu_ninguna, fail) :-
	vieneZafando(_,maiu).
test(vieneZafando_juan_himym, nondet) :-
	vieneZafando(himym,juan).
test(vieneZafando_juan_got, nondet) :-
	vieneZafando(got,juan).
test(vieneZafando_juan_hoc, nondet) :-
	vieneZafando(hoc,juan).
test(vieneZafando_nico_starWars, set(UnaPersona == [nico])) :-
	vieneZafando(starWars,UnaPersona).


:- end_tests(spoiler_alert).

% SEGUNDA ENTREGA

/*
malaGente(Persona):-
    esPersona(Persona),
    forall(leDijo(Persona,PersonaDos,Serie,_),leSpoileo(Persona,PersonaDos,Serie)).
*/

malaGente(Persona):-
    esPersona(Persona),
    not((leDijo(Persona,PersonaDos,Serie,_), not(leSpoileo(Persona,PersonaDos,Serie)))).

malaGente(Persona):-
    esPersona(Persona),
    leSpoileo(Persona,_,Serie),
    not(quienMiraQue(Persona,Serie)).

amigo(nico, maiu).
amigo(maiu, gaston).
amigo(maiu, juan).
amigo(juan, aye).

fullSpoil(PersonaUno,PersonaDos):-
    leSpoileo(PersonaUno,PersonaDos,_).

fullSpoil(PersonaUno,PersonaDos):-
    amigo(AmigoDePersonaDos, PersonaDos),
	PersonaUno \= PersonaDos,
    fullSpoil(PersonaUno,AmigoDePersonaDos).



:- begin_tests(malaGente).
test(esMalaGente_Gaston, nondet) :-
	malaGente(gaston).
test(esMalaGente_Nico,nondet):-
  malaGente(nico).
test(esMalaGente_Pedro,fail):-
  malaGente(pedro).
:- end_tests(malaGente).



:- begin_tests(series_fuertes).
test(series_fuertes_futurama,nondet):-
 esFuerte(futurama,muerte(seymourDiera)).
test(series_fuertes_starWars,nondet):-
 esFuerte(starWars,muerte(emperor)).
test(series_fuertes_starWars,nondet):-
  esFuerte(starWars,relacion(parentesco, anakin, rey)).
test(series_fuertes_starWars,nondet):-
  esFuerte(starWars,relacion(parentesco, vader, luke)).
test(series_fuertes_himym,nondet):-
  esFuerte(himym,relacion(amorosa, ted, robin)).
test(series_fuertes_himym,nondet):-
  esFuerte(himym,relacion(amorosa, swarley, robin)).
test(series_fuertes_himym,nondet):-
  esFuerte(himym,relacion(amorosa, swarley, robin)).
test(series_fuertes_got,nondet):-
  esFuerte(got,plotTwist([fuego, boda])).
test(series_fuertes_got,fail):-
  esFuerte(got,plotTwist([suenio, sinPiernas])).
test(series_fuertes_drHouse,fail):-
  esFuerte(drHouse,plotTwist([coma, pastillas])).
:- end_tests(series_fuertes).


:- begin_tests(full_spoiler).
test(full_spoiler_Nico,set(UnaPersona==[aye,juan,maiu,gaston])):-
 fullSpoil(nico,UnaPersona).
test(full_spoiler_Gaston,set(UnaPersona==[aye,juan,maiu])):-
 fullSpoil(gaston,UnaPersona).
test(full_spoiler_Maiu,nondet):-
 not(fullSpoil(maiu,_)).


:- end_tests(full_spoiler).
