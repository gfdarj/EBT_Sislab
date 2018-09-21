using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.DirectoryServices;
using Embratel.Sislab.Entidades;
using Embratel.Sislab.Util;

namespace Embratel.Sislab.Classes
{
    public class UsuariosAD
    {
        public UsuarioENT ObtemUsuario(string login)
        {
            UsuarioENT ent = null;

            // Get the currently connected LDAP context 
            DirectoryEntry entry1 = new DirectoryEntry(ConfigHelper.LDAP);
            // Use the default naming context as the connected context may not work for searches
            string domainContext = entry1.Properties["defaultNamingContext"].Value as string;

            DirectoryEntry entry = new DirectoryEntry("LDAP://" + domainContext);
            DirectorySearcher adSearch = new DirectorySearcher(entry);

            adSearch.Filter = "(&(objectClass=user)(anr=" + login + "))";

            // Go through all entries from the active directory.
            foreach (SearchResult singleADUser in adSearch.FindAll())
            {
                // Go through all the values found in the search
                //ent.DN = ((ResultPropertyCollection)singleADUser.Properties)["distinguishedName"].ToString();
                ent.Nome = ((ResultPropertyCollection)singleADUser.Properties)["displayname"].ToString();
                ent.Email = ((ResultPropertyCollection)singleADUser.Properties)["mail"].ToString();

                /*                ent.CodigoLotacao = ((ResultPropertyCollection)singleADUser.Properties)["embratellotacao"].ToString();
                                ent.Departamento = ((ResultPropertyCollection)singleADUser.Properties)["department"].ToString();
                                ent.Diretoria = ((ResultPropertyCollection)singleADUser.Properties)["embrateldescdsmdlotacao"].ToString();
                                ent.Sexo = ((ResultPropertyCollection)singleADUser.Properties)["embratelsexo"].ToString();
                                ent.CategoriaEmpregado = ((ResultPropertyCollection)singleADUser.Properties)["embratelcatempregado"].ToString();
                                ent.DataAdmissao = ((ResultPropertyCollection)singleADUser.Properties)["embrateladmissao"].ToString();
                                ent.AreaLotacao = ((ResultPropertyCollection)singleADUser.Properties)["embratelarealotacao"].ToString();
                                ent.CategoriaCargo = ((ResultPropertyCollection)singleADUser.Properties)["embratelcatcargo"].ToString();
                                ent.Lotacao = ((ResultPropertyCollection)singleADUser.Properties)["embrateldesclotacao"].ToString();
                                ent.Matricula = ((ResultPropertyCollection)singleADUser.Properties)["employeeid"].ToString();
                                ent.DataNascimento = ((ResultPropertyCollection)singleADUser.Properties)["embrateldatanasc"].ToString();
                                ent.Empresa = ((ResultPropertyCollection)singleADUser.Properties)["company"].ToString();
                                ent.Telefone = ((ResultPropertyCollection)singleADUser.Properties)["telephonenumber"].ToString();
                                ent.Celular = ((ResultPropertyCollection)singleADUser.Properties)["mobile"].ToString();
                */
            }

            return ent;
        }

    }
}



