show tables;

/* 대분류 */
create table categoryMain (
  categoryMainCode   char(1) not null,	    /* 대분류코드(A,B,C,... => 영문 대문자 1자 */
  categoryMainName  varchar(20) not null,  /* 대분류명(회사명 => 삼성/LG/현대... */
  primary key(categoryMainCode),
  unique key(categoryMainName)
);

/* 중분류 */
create table categoryMiddle (
  categoryMainCode   char(1) not null,         /* 대분류코드를 외래키로 지정 */
  categoryMiddleCode   char(2) not null,	       /* 중분류코드(01,02,03,... => 숫자(문자형식) 2자 */
  categoryMiddleName  varchar(20) not null, /* 중분류명(제품분류명=> 전자제품/의류/신발류/차종.. */
  primary key(categoryMiddleCode),
  /* unique key(categoryMiddleName) */
  foreign key(categoryMainCode) references categoryMain(categoryMainCode)
);

/* 소분류 */
create table categorySub (
  categoryMainCode   char(1) not null,         /* 대분류코드를 외래키로 지정 */
  categoryMiddleCode   char(2) not null,      /* 중분류코드를 외래키로 지정 */
  categorySubCode   char(3) not null,	      /* 소분류코드(001,002,003,... => 숫자(문자형식) 3자리 */
  categorySubName  varchar(20) not null,    /* 소분류명(상품구분=> 냉장고/에어컨/오디오/TV.. */
  primary key(categorySubCode),
  /* unique key(categorySubName) */
  foreign key(categoryMainCode) references categoryMain(categoryMainCode),
  foreign key(categoryMiddleCode) references categoryMiddle(categoryMiddleCode)
);

/* 세분류(상품 테이블) */
create table dbProduct (
  idx   int  not  null,                 /* 상품 고유번호 */
  categoryMainCode    char(1) not null,      /* 대분류코드를 외래키지정 */
  categoryMiddleCode  char(2) not null,     /* 중분류코드를 외래키로 지정 */
  categorySubCode      char(3) not null,      /* 소분류코드를 외래키로 지정 */
  productCode  varchar(20)  not null,        /* 상품고유코드(대분류코드+중코드+소코드+고유번호) */
  productName varchar(50)  not null,       /* 상품명(상품모델명) - 세분류 */
  detail       varchar(100)  not null,            /* 상품의 간단설명(초기화면출력에 필요) */
  mainPrice  int not null,                        /* 상품의 기본가격 */
  fSName    varchar(100)  not null,          /* 상품의 기본사진(여기선 1장만 처리) */
  content    text  not null,                      /* 상품의 상세설명 - ckeditor를 이용한 이미지처리 */
  primary key(idx, productCode),
  unique  key(productName),
  foreign key(categoryMainCode) references categoryMain(categoryMainCode),
  foreign key(categoryMiddleCode) references categoryMiddle(categoryMiddleCode),
  foreign key(categorySubCode) references categorySub(categorySubCode)
);

/* 상품 옵션 */
create table dbOption (
  idx      int not null auto_increment,   /* 옵션 고유번호 */
  productIdx int not null,                  /* product테이블(상품)의 고유번호 - 외래키 지정 */
  optionName varchar(50) not null,    /* 옵션 이름 */
  optionPrice  int not null default 0,   /* 옵션 가격 */
  primary key(idx),
  foreign key(productIdx) references dbProduct(idx)
);

drop table categoryMain;
drop table categoryMiddle;
drop table categorySub;
drop table dbProduct;
drop table dbOption;

desc categoryMain;
desc categoryMiddle;
desc categorySub;
desc dbProduct;
desc dbOption;

select * from cateGoryMain;
select * from cateGoryMiddle;
select * from cateGorySub;
select * from dbProduct;
select * from dbOption;

