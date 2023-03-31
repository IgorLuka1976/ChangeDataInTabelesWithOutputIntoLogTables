-----Important
USE AdventureWorks2019
GO

CREATE PROCEDURE Purchasing.UpdatePaymentsLT @IdPayment INT,@PayDate DATETIME, @PayAmount MONEY
AS
BEGIN

BEGIN TRY
BEGIN TRANSACTION

UPDATE p
SET PayDate = @PayDate,  
    PayAmount = @PayAmount   
	
OUTPUT inserted.IdPayment,inserted.ProductID,     
       deleted.PayDate, 
	   deleted.PayAmount, 
       inserted.PayDate,  
       inserted.PayAmount  
INTO Purchasing.logChangePaymentsLT
FROM [Purchasing].[paymentsLT] p  
WHERE p.IdPayment=@IdPayment

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
