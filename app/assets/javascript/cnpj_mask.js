cnpjInput = document.getElementById("supplier_cnpj")
function cnpjMask(cnpj) {
  return cnpj
  .replace(/\D/g, '')
  .replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/g,"\$1.\$2.\$3\/\$4\-\$5")
}

cnpjInput.addEventListener('input', function () {
  cnpjInput.value = cnpjMask(cnpjInput.value)
})