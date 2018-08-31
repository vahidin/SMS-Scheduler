--------------------------------------------------------
--  DDL for Package PK_00_CUS_PRC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_00_CUS_PRC" AS  
 
-- Author       : Gbenga Cruz 
-- Description  : SMS Template Management
-- Date         : January 18, 2017 
 
  
     --- SMS Template Management
     PROCEDURE PC_00_CUS_SMS (p_sms IN v_00_cus_sms%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
         
     ---- SMS Job Management
     PROCEDURE PC_00_SMS_JOB (p_sms IN v_00_cus_sms%ROWTYPE, p_job IN v_00_sms_job%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
        --- SMS Process

     PROCEDURE PC_00_JOB_PRC (p_sms IN v_00_cus_sms%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
       --- SMS Manual Process 

     PROCEDURE PC_00_JOB_PRC_MNL (p_sms IN v_00_cus_sms%ROWTYPE,p_cus_id IN NUMBER, p_err_msg OUT v_99_ssu_log.err_msg%TYPE);
     
       
    --- Drop job
    PROCEDURE PC_00_JOB_DROP (p_job IN v_00_job_sta%ROWTYPE,  p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
    
    --- Disable job
    PROCEDURE PC_00_JOB_DISABLE (p_job IN v_00_job_sta%ROWTYPE,  p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
    
        --- Enable job
    PROCEDURE PC_00_JOB_ENABLE (p_job IN v_00_job_sta%ROWTYPE,  p_err_msg OUT v_99_ssu_log.err_msg%TYPE) ;
     
END PK_00_CUS_PRC;

/
