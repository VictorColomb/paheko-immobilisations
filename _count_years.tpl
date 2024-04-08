{{if !$date || !$duration}}
    {{:error message="Fonction 'count_years' : paramètre duration ou date manquant !"}}
{{/if}}

{{:include
    file="./_find_year.tpl"
    date=$date

    keep="amort_year_start"
}}

{{:assign var="number_of_years" value="%d+1"|math:$duration}}
{{if $amort_year_start == $date}}
    {{:assign var="number_of_years" value=$duration}}
{{/if}}
