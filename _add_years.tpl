{{if !$date || $years === null}}
    {{:error message="Fonction 'add_years' : paramètre date ou years manquant !"}}
{{/if}}

{{:assign var="mj" value=$date|substr:4}}
{{:assign var="year" value=$date|substr:0:4}}
{{:assign var="year" value="%s+%d"|math:$year:$years}}

{{:assign var="date_index" value=$year|cat:$mj}}
