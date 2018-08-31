--------------------------------------------------------
--  DDL for Package Body PK_00_CUS_PRC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_00_CUS_PRC" AS 
 
-- Author       : Gbenga Cruz 
-- Description  : Message logger Job  Management
-- Date         : January 18, 2017 
 
 
  
  
   ---- Job Management
    PROCEDURE PC_00_SMS_JOB (p_sms IN v_00_cus_sms%ROWTYPE, p_job IN v_00_sms_job%ROWTYPE, p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS
  
     v_err     v_99_ssu_log%ROWTYPE; 
     v_sms     v_00_cus_sms%ROWTYPE;
     v_job     v_00_sms_job%ROWTYPE;
     v_drp     BOOLEAN;
     BEGIN
         
         v_job.job_cmt   :=  p_job.job_cmt;
         v_job.job_nm    :=  'AEROSOL'||s_00_job_nm.NEXTVAL;
         v_job.st_dt     :=  p_job.st_dt;
         v_job.en_dt     :=  p_job.en_dt;
         v_job.job_drp   :=  p_job.job_drp;
         v_job.freq      :=  p_job.freq;
         
          IF v_job.job_drp = 1 THEN 
           v_drp := true;
           ELSE
           v_drp := false; 
          END IF;
          
     
         IF v_err.err_msg IS NULL THEN 
         
         DBMS_SCHEDULER.CREATE_JOB (
            job_name => v_job.job_nm,
            job_type => 'PLSQL_BLOCK',
            job_action => ' DECLARE v_sms  v_00_cus_sms%ROWTYPE; v_err v_99_ssu_log%ROWTYPE; BEGIN
             v_sms.r_k := '||p_sms.r_k||'; 
             PK_00_CUS_PRC.PC_00_JOB_PRC(v_sms,v_err.err_msg) ;
             END;',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ(v_job.st_dt,'DD-MON-YYYY HH24:MI:SS.FF'),
            repeat_interval => v_job.freq,
            end_date =>TO_TIMESTAMP_TZ(v_job.en_dt,'DD-MON-YYYY HH24:MI:SS.FF'),
            enabled => TRUE,
            auto_drop => v_drp,
            comments => v_job.job_cmt);
    
     
         DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => v_job.job_nm, 
             attribute => 'store_output', value => TRUE);
         DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => v_job.job_nm, 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_FULL);
             
         END IF;     
       EXCEPTION WHEN OTHERS THEN 
             ROLLBACK; 
		     pk_99_ssu_err.pc_99_ssu_err(v_err);       
             p_err_msg := v_err.err_msg; 
        
  END PC_00_SMS_JOB;
  

  
    --- Drop job
    PROCEDURE PC_00_JOB_DROP (p_job IN v_00_job_sta%ROWTYPE,  p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS 
    
     v_err  v_99_ssu_log%ROWTYPE; 
     v_job v_00_job_sta%ROWTYPE;
     
     BEGIN
     
         v_job.job_name := p_job.job_name;
     
         DBMS_SCHEDULER.DROP_JOB(job_name => v_job.job_name,
                                defer => false,
                                force => true);
                                
     	EXCEPTION WHEN OTHERS THEN 
        ROLLBACK; 
         
        -- raise;
		pk_99_ssu_err.pc_99_ssu_err(v_err);       
        p_err_msg := v_err.err_msg; 
        
     END PC_00_JOB_DROP;
     
     
      --- Disable job
    PROCEDURE PC_00_JOB_DISABLE (p_job IN v_00_job_sta%ROWTYPE,  p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS 
    
     v_err  v_99_ssu_log%ROWTYPE; 
     v_job v_00_job_sta%ROWTYPE;
     
     BEGIN
     
         v_job.job_name := p_job.job_name;
     
         DBMS_SCHEDULER.disable(name => v_job.job_name,
                                force => true);
                                
     	EXCEPTION WHEN OTHERS THEN 
        ROLLBACK; 
         
        -- raise;
		pk_99_ssu_err.pc_99_ssu_err(v_err);       
        p_err_msg := v_err.err_msg; 
        
     END PC_00_JOB_DISABLE;
     
     
    --- Enable job
    PROCEDURE PC_00_JOB_ENABLE (p_job IN v_00_job_sta%ROWTYPE,  p_err_msg OUT v_99_ssu_log.err_msg%TYPE) AS 
    
     v_err  v_99_ssu_log%ROWTYPE; 
     v_job v_00_job_sta%ROWTYPE;
     
     BEGIN
     
         v_job.job_name := p_job.job_name;
     
         DBMS_SCHEDULER.enable(name => v_job.job_name);
                                
     	EXCEPTION WHEN OTHERS THEN 
        ROLLBACK; 
         
        -- raise;
		pk_99_ssu_err.pc_99_ssu_err(v_err);       
        p_err_msg := v_err.err_msg; 
        
     END PC_00_JOB_ENABLE;
  
  END PK_00_CUS_PRC;

/
