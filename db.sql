SET FOREIGN_KEY_CHECKS=0;
create database if not exists `hospital`;
use `hospital`;


/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     2020/7/6 21:38:41                            */
/*==============================================================*/


drop table if exists department;

drop table if exists doctor;

drop table if exists duty;

drop table if exists medicine;

drop table if exists patient;

drop table if exists prescription;

drop table if exists registration;

drop table if exists visit;

/*==============================================================*/
/* Table: department                                            */
/*==============================================================*/
create table department 
(
   id                   varchar(50)                    null,
   department_no        varchar(50)                    null,
   department_name      varchar(50)                    null,
   is_deleted           varchar(50)                    null,
   create_time          timestamp                      null,
   update_time          timestamp                      null
);

/*==============================================================*/
/* Table: doctor                                                */
/*==============================================================*/
create table doctor 
(
   id                   varchar(50)                    null,
   doctor_no            varchar(50)                    null,
   doctor_name          varchar(50)                    null,
   doctor_password      varchar(50)                    null,
   doctor_salt          varchar(50)                    null,
   doctor_sex           varchar(50)                    null,
   doctor_birth         date                           null,
   doctor_phone         varchar(50)                    null,
   doctor_registration_fee double                         null,
   doctor_hire_time     date                           null,
   doctor_department_no varchar(50)                    null,
   doctor_quit_time     date                           null,
   type                 varchar(50)                    null,
   create_time          timestamp                      null,
   update_time          timestamp                      null
);

/*==============================================================*/
/* Table: duty                                                  */
/*==============================================================*/
create table duty 
(
   id                   varchar(50)                    null,
   doctor_no            varchar(50)                    null,
   Monday               varchar(50)                    null,
   Monday_rest          integer                        null,
   Tuesday              varchar(50)                    null,
   Tuesday_rest         integer                        null,
   Wednesday            varchar(50)                    null,
   Wednesday_rest       integer                        null,
   Thursday             varchar(50)                    null,
   Thursday_rest        integer                        null,
   Friday               varchar(50)                    null,
   Friday_rest          integer                        null,
   Saturday             varchar(50)                    null,
   Saturday_rest        integer                        null,
   Sunday               varchar(50)                    null,
   Sunday_rest          integer                        null
);

/*==============================================================*/
/* Table: medicine                                              */
/*==============================================================*/
create table medicine 
(
   id                   varchar(0)                     null,
   medicine_no          varchar(0)                     null,
   medicine_name        varchar(0)                     null,
   medicine_price       double                         null,
   medicine_amount      integer                        null,
   medicine_last_add_account integer                        null,
   update_time          timestamp                      null
);

/*==============================================================*/
/* Table: patient                                               */
/*==============================================================*/
create table patient 
(
   id                   varchar(50)                    null,
   patient_no           varchar(50)                    null,
   patient_name         varchar(50)                    null,
   patient_password     varchar(50)                    null,
   patient_salt         varchar(50)                    null,
   patient_sex          varchar(50)                    null,
   patient_birth        date                           null,
   patient_phone        varchar(50)                    null,
   is_deleted           varchar(50)                    null,
   create_time          timestamp                      null,
   update_time          timestamp                      null
);

/*==============================================================*/
/* Table: prescription                                          */
/*==============================================================*/
create table prescription 
(
   id                   varchar(50)                    null,
   registration_no      varchar(50)                    null,
   medicine_no          varchar(50)                    null,
   medicine_amount      integer                        null
);

/*==============================================================*/
/* Table: registration                                          */
/*==============================================================*/
create table registration 
(
   id                   varchar(50)                    null,
   registration_no      varchar(50)                    null,
   patient_no           varchar(50)                    null,
   department_no        varchar(50)                    null,
   doctor_no            varchar(50)                    null,
   appointment_time     timestamp                      null,
   visit_time           date                           null,
   status               varchar(50)                    null,
   create_time          timestamp                      null,
   update_time          timestamp                      null
);

/*==============================================================*/
/* Table: visit                                                 */
/*==============================================================*/
create table visit 
(
   id                   varchar(50)                    null,
   registration_no      varchar(50)                    null,
   patient_no           varchar(50)                    null,
   department_no        varchar(50)                    null,
   doctor_no            varchar(50)                    null,
   appointment_time     timestamp                      null,
   visit_time           date                           null,
   status               varchar(50)                    null,
   create_time          timestamp                      null,
   update_time          timestamp                      null
);