cepInput = document.getElementById("warehouse_cep")

function cepMask(cep){
  return cep
    .replace(/\D/g,"")
    .replace(/^(\d{5})(\d)/,"$1-$2")
}

cepInput.addEventListener('input', function () {
  cepInput.value = cepMask(cepInput.value)
})
