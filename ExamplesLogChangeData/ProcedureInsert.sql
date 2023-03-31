-----Important
USE AdventureWorks2019
GO

CREATE PROCEDURE Purchasing.InsertPaymentsLT @ProductID INT,@PayDate DATETIME, @PayAmount MONEY
AS
BEGIN

BEGIN TRY
BEGIN TRANSACTION

INSERT INTO [Purchasing].[paymentsLT]
   (
				   ProductID                
                  ,PayDate 
			      ,PayAmount)
		   	 OUTPUT inserted.IdPayment,
			        @ProductID,     
                    @PayDate, 
             	    @PayAmount, 					
                    inserted.PayDate,  
                    inserted.PayAmount  
             INTO Purchasing.logChangePaymentsLT 
VALUES (
         @ProductID
		,@PayDate
		,@PayAmount
       )          


COMMIT TRANSACTION
END TRY

  BEGIN CATCH
     IF XACT_STATE() <> 0 ROLLBACK TRANSACTION
	 PRINT 'Unable to insert record'
	 ;THROW
	 RETURN -1
  END CATCH
  RETURN 0
END
