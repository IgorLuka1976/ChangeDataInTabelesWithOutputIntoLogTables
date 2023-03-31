-----Important
USE AdventureWorks2019
GO

CREATE PROCEDURE Purchasing.MergePaymentsLT @ProductID INT, @PayDate DATETIME, @PayAmount MONEY 
AS
BEGIN

---@ProductID only for Insert part of Merge, Default=0

DECLARE @payment TABLE(ProductID INT,PayDate DATETIME,PayAmount MONEY)

INSERT INTO @payment
VALUES (@ProductID, @PayDate, @PayAmount)

BEGIN TRY
BEGIN TRANSACTION

MERGE Purchasing.paymentsLT WITH (SERIALIZABLE) AS target
		USING 
		   (  
			SELECT 
			   ProductID
			  ,PayDate 
			  ,PayAmount
			FROM @payment
		   ) AS source
		   ON  source.ProductID=target.ProductID	
		 WHEN MATCHED THEN
           UPDATE 
		     SET PayDate = @PayDate,  
                 PayAmount = @PayAmount
		 WHEN NOT MATCHED BY TARGET THEN
           INSERT
                  (
				   ProductID                
                  ,PayDate 
			      ,PayAmount)
           VALUES
                 (
				  @ProductID
                 ,source.PayDate 
			     ,source.PayAmount) 

	         OUTPUT inserted.IdPayment
			       ,source.ProductID,     
                    deleted.PayDate, 
             	    deleted.PayAmount, 					
                    inserted.PayDate,  
                    inserted.PayAmount  
             INTO Purchasing.logChangePaymentsLT ;

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
