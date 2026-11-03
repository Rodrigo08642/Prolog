# Árbol de Decisiones en CLISP - Star Wars

---

## Extracción con car y cdr
- **car:** Obtiene el primer elemento (la clave del nodo).
- **cdr:** Obtiene el resto de la lista (los datos o subárboles, sin la clave).
- **cadr:** Obtiene directamente el primer valor dentro del contenido (`car` del `cdr`).

```lisp
(car (assoc 'antigua_republica_legends *starWars*)) ; => ANTIGUA_REPUBLIC_LEGENDS
(cdr (assoc 'antigua_republica_legends *starWars*)) ; ((ORDEN_JEDI ...) (IMPERIO_SITH ...))
``` 

## Niveles

1. **Era / Período:** `antigua_republica_legends`, `guerras_clon`, `guerra_civil_galactica`
2. **Facción / Grupo:** `orden_jedi`, `imperio_sith`, `republica_galactica`, `confederacion_separatista`, `alianza_rebelde`, `imperio_galactico`, `cazarrecompensas_inframundo`
3. **Género:** `hombre`, `mujer`, `droide`
4. **Especie / Raza:** `humano`, `togruta`, `twi_lek`, `wookiee`, `trandoshano`, `droide_asesino`, `droide_astromec`
5. **Rol / Características:** Personalidad o función distintiva del personaje
6. **Personaje:** Nombre específico del personaje en Lisp (`(revan)`, `(bastila_shan)`, `(darth_traya)`, etc.)

---

## Código:

```lisp
; ====== NIVELES STAR WARS
; 1. Era (antigua_republica_legends, guerras_clon, guerra_civil_galactica)
; 2. Faccion (orden_jedi, imperio_sith, republica_galactica, confederacion_separatista, alianza_rebelde, imperio_galactico, cazarrecompensas_inframundo)
; 3. Genero (hombre / mujer / droide)
; 4. Especie (humano, togruta, twi_lek, wookiee, trandoshano, droide_asesino)
; 5. Personalidad/Rol/Caracteristica
; 6. Personaje (revan, bastila_shan, darth_traya, malak, darth_nihilus, anakin_skywalker...)

(defparameter *starWars*  '(
    ;-------------------------------------------------------------------------------
    (antigua_republica_legends
      ; orden_jedi
      (orden_jedi
        (mujer
          (humano
            (jedi_con_meditacion_de_batalla (bastila_shan))
            (exiliada_de_la_fuerza (meetra_surik))))
        (hombre
          (humano
            (caballero_caido_y_redimido (revan)))))

      ; imperio_sith
      (imperio_sith
        (mujer
          (humano
            (maestra_sith_manipuladora_del_triunvirato (darth_traya))))
        (hombre
          (humano
            (lord_sith_que_traiciono_y_usurpo_a_su_maestro (malak))
            (lord_sith_devorador_de_mundos (darth_nihilus))))))

    ;-------------------------------------------------------------------------------
    (guerras_clon
      ; republica_galactica
      (republica_galactica
        (mujer
          (togruta
            (padawan_rebelde_y_valiente (ahsoka_tano)))
          (humano
            (senadora_idealista_y_luchadora (padme_amidala))))
        (hombre
          (humano
            (caballero_jedi_arrogante_y_poderoso (anakin_skywalker))
            (maestro_jedi_diplomatico_y_calmado (obi_wan_kenobi))
            (capitan_clone_lider_veterano (rex_ct7567)))))

      ; confederacion_separatista
      (confederacion_separatista
        (hombre
          (humano
            (conde_lider_carismatico_y_espadachin (conde_dooku)))
          (trandoshano
            (lider_mercenario_y_rastreador (bossk))))
        (droide
          (droide_asesino
            (general_cyborg_odiador_de_jedi (general_grievous))))))

    ;-------------------------------------------------------------------------------
    (guerra_civil_galactica
      ; alianza_rebelde
      (alianza_rebelde
        (mujer
          (humano
            (lider_rebelde_firme_y_estrategica (leia_organa)))
          (twi_lek
            (espia_rebelde_y_luchadora (hera_syndulla))))
        (hombre
          (humano
            (joven_granjero_convertido_en_jedi (luke_skywalker))
            (contrabandista_cinico_con_buen_corazon (han_solo)))
          (wookiee
            (guerrero_fiel_de_voz_rugiente (chewbacca)))
          (droide
            (droide_astromec
              (droide_astromec_sarcastico_y_leal (r2d2))))))

      ; imperio_galactico
      (imperio_galactico
        (hombre
          (humano
            (lord_sith_cibernetico_aterrador (darth_vader))
            (emperador_manipulador_y_maquiavelico (palpatine))
            (gran_moff_estricto_y_calculador (grand_moff_tarkin)))))

      ; cazarrecompensas_y_inframundo
      (cazarrecompensas_inframundo
        (hombre
          (humano
            (cazarrecompensas_silencioso_y_legendario (boba_fett))))))))
```