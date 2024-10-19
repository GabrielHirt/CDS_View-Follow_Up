@AbapCatalog.sqlViewName: 'ZDD_WRKFLOW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Relatório Compras'
@OData.publish: true
//@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST,#GROUP_BY]


define view ZDD_WORKFLOW as select from 
  ekpo
  left outer join ekko on ekpo.ebeln = ekko.ebeln
  left outer join eket on ekpo.ebeln = eket.ebeln and ekpo.ebelp = eket.ebelp
  left outer join zmmt0002 on ekpo.matnr = zmmt0002.matnr
  left outer join lfa1 on ekko.lifnr = lfa1.lifnr
  left outer join eban on ekpo.banfn = eban.banfn and ekpo.bnfpo = eban.bnfpo
  left outer join mara on ekpo.matnr = mara.matnr
  left outer join lfa1 as LFA1_FABRIC on mara.mfrnr = LFA1_FABRIC.lifnr
  left outer join ekkn on ekpo.ebeln = ekkn.ebeln and ekpo.ebelp = ekkn.ebelp
  left outer join t16fs on ekko.frggr = t16fs.frggr and ekko.frgsx = t16fs.frgsx
  left outer join t16fe on ekko.frgke = t16fe.frgke
  left outer join aufk on ekkn.aufnr = aufk.aufnr
  left outer join ZCDS_HRP1000 on aufk.aufnr = ZCDS_HRP1000.HRP1001_OBJID
  left outer join zsrgbtbrel on ekpo.ebeln = zsrgbtbrel.instid_a

{
    key ekpo.ebeln as PEDIDO,
    ekpo.creationdate as DATA_CRIACAO,
    ekpo.creationtime as HORA_CRIACAO,
    ekpo.aedat as DATA_ULT_MODIF,
    ekko.lifnr as NUM_FORNEC,
    CONCAT(CONCAT(lfa1.name1, ' '), CONCAT(lfa1.name2, CONCAT(' ', lfa1.name3))) as NOME_FORNEC,
    ekpo.loekz as COD_ELIMINACAO,  
    ekpo.ebelp as ITEM_PEDIDO,
    eket.etenr as DIV_DA_REMESSA,
    LTRIM(ekpo.matnr, '0') as COD_MATERIAL,
    zmmt0002.text as HANA_CODE,
    ekpo.txz01 as DESCRICAO_BREVE,
    ekpo.konnr as CONTRATO_BASICO,
    ekpo.knttp as CTG_CLASS_CONT,
    ekko.bsart as TIPO_DOC_COMPRAS,
    ekko.ekgrp as GRP_COMP,
    ekpo.menge as QTD_PEDIDO    ,
    ekpo.meins as UNIDADE_PEDIDO,
    ekpo.netpr as PRECO_LIQUIDO,
    ekko.waers as MOEDA,                                    
    ekpo.peinh as UNID_PRECO,
    eket.menge as QTD_DIVISAO,
    t16fe.frget as STATU,  
    eket.eindt as DATA_DE_REMESSA,
    eket.wemng as QTD_ENTRADA,
   
    case
        when ekpo.loekz = 'L' then 0
        else eket.menge - eket.wemng
    end as A_SER_FORNECIDA, 
  
    (cast(ekpo.netpr as float) / cast(ekpo.peinh as float)) * cast((case when ekpo.loekz = 'L' then 0
    else (cast(eket.menge as float) - cast(eket.wemng as float)) end) as float) as AINDA_A_FATURAR,
    ekko.frgke as COD_STATUS_AUTORIZACAO,
    t16fe.frget as STATUS_AUTORIZACAO,
    aufk.veraa_user as ORD_NIVEL2,
     ZCDS_HRP1000.HRP1000_STEXT_1 as ORD_NIVEL1, 
    ekko.frggr as GRP_LIBERACAO,
    ekko.frgsx as COD_ESTRAT_LIB,
    ekko.frgzu as ESTADO_LIBERACAO,
    ekko.zterm as CONDICAO_PGTO,
    ekko.zbd1t as PGTO_EM,
    ekko.ernam as CRIADO_POR,
    ekpo.banfn as RC,
    ekpo.bnfpo as ITEM_RC,
    eban.lfdat as DATA_REMESSA_RC,
    ekpo.afnam as REQUISITANTE,
    ekkn.kostl as CENTRO_DE_CUSTO,
    ekkn.aufnr as ORDEM,
    ekkn.sakto as CONTA_DO_RAZAO,
    ekpo.j_1bnbm as NCM,
    mara.mfrnr as NUM_FABRICANTE,
    mara.mfrpn as PART_NUMBER,
    ekpo.plifz as PRZ_ENTREGA_PREV,
    ekpo.webaz as TEMPO_PCMTO_EM,
    lfa1.stras as ENDERECO,
    lfa1.ort01 as CIDADE,
    lfa1.pstlz as COD_POSTAL,
    lfa1.regio as REGIAO,
    lfa1.ort02 as DISTRITO,
    zsrgbtbrel.instid_a as CONTEM_ANEXO
}

where ekpo.creationdate > '20200101'