---
---

# Architecture Decision Records

{% assign adrs = site.pages | where_exp: "p", "p.path contains 'adr/'" | sort: "path" %}
{% for adr in adrs %}
{% unless adr.path contains 'index' or adr.path contains 'template' %}
- [{{ adr.path | remove: 'adr/' | remove: '.md' | replace: '-', ' ' }}]({{ adr.url }})
{% endunless %}
{% endfor %}