rm -r addOrg4
cp -r addOrg3 addOrg4
cd addOrg4


mv addOrg3.sh addOrg4.sh
mv ./docker/docker-compose-ca-org3.yaml ./docker/docker-compose-ca-org4.yaml 
mv ./docker/docker-compose-couch-org3.yaml ./docker/docker-compose-couch-org4.yaml 
mv ./docker/docker-compose-org3.yaml ./docker/docker-compose-org4.yaml 
mv ./fabric-ca/org3 ./fabric-ca/org4
mv org3-crypto.yaml  org4-crypto.yaml
grep -rli 'org3' * | xargs -i@ sed -i 's/org3/org4/g' @
grep -rli 'Org3' * | xargs -i@ sed -i 's/Org3/Org4/g' @
grep -rli 'ORG3' * | xargs -i@ sed -i 's/ORG3/ORG4/g' @
grep -rli '11051' * | xargs -i@ sed -i 's/11051/12051/g' @

tree .

cd ..

rm -r scripts/org4-scripts
cp -r scripts/org3-scripts scripts/org4-scripts
cd scripts/org4-scripts
grep -rli 'org3' * | xargs -i@ sed -i 's/org3/org4/g' @
grep -rli 'Org3' * | xargs -i@ sed -i 's/Org3/Org4/g' @
grep -rli 'ORG3' * | xargs -i@ sed -i 's/ORG3/ORG4/g' @
grep -rli '11051' * | xargs -i@ sed -i 's/11051/12051/g' @

tree .